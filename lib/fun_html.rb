# frozen_string_literal: true

require_relative 'fun_html/node_definitions'
require_relative 'fun_html/attribute_definitions'
require_relative 'fun_html/version'
require 'erb/escape'

# nodoc
module FunHtml
  # nodoc
  module Writer
    def text(value)
      (@__buffer ||= +'') << ERB::Escape.html_escape(value)
      self
    end

    def attr(&blk) # rubocop:disable Style/ArgumentsForwarding
      Attribute.new(&blk) # rubocop:disable Style/ArgumentsForwarding
    end

    def comment(comment_text = nil)
      write('<!--', '-->', nil, closing_char: '', closing_void_char: '-->') { text comment_text }
    end

    def doctype
      (@__buffer ||= +'') << '<!DOCTYPE html>'
      self
    end

    def script(attributes = nil, &block) # rubocop:disable Lint/UnusedMethodArgument
      body = yield
      write('<script', '</script>', attributes) { send :unsafe_text, body }
    end

    # insert the output of the given template into this template
    def include(template)
      @__buffer << template.render
      self
    end

    def render
      @__buffer
    ensure
      # empty the buffer to prevent double rendering
      @__buffer = +''
    end

    private

    def unsafe_text(value)
      (@__buffer ||= +'') << value
      self
    end

    CLOSE = '>'
    CLOSE_VOID = '/>'

    def write(open, close, attr = nil, closing_char: CLOSE, closing_void_char: CLOSE_VOID, &block)
      (@__buffer ||= +'') << open << Attribute.to_html(attr)

      if block
        @__buffer << closing_char

        begin
          yield
        # it is faster to error and try than to detect the type and branch
        rescue StandardError
          instance_eval(&block)
        end
        @__buffer << close
      else
        @__buffer << closing_void_char
      end

      self
    end
  end

  # nodoc
  class Template
    include FunHtml::Writer
    include FunHtml::NodeDefinitions::HTMLAllElements
  end

  # nodoc
  class Attribute
    include FunHtml::AttributeDefinitions

    # only allow nil or objects that respond to `safe_attribute`
    def self.to_html(attr)
      attr&.safe_attribute.to_s
    end

    # create a new Attribute object to create reuseable attributes
    def initialize(buffer = {}, &block)
      @__buffer = buffer
      return unless block

      yield self
    end

    # merge two attribute sets together
    def merge(other)
      self.class.new(@__buffer.merge(other.instance_variable_get(:@__buffer)))
    end

    def safe_attribute
      @__buffer.values.join
    end

    private

    def write(name, value)
      @__buffer[name] = "#{name}#{ERB::Escape.html_escape(value)}\""
      self
    end

    def write_empty(name, print)
      @__buffer[name] = print ? name : ''
      self
    end
  end
end
