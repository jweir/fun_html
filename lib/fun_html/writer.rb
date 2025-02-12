# typed: strict
# frozen_string_literal: true

require_relative 'node_definitions'
require 'erb/escape'

module FunHtml
  # nodoc
  module Writer
    include Kernel

    def initialize
      @__buffer = +''
    end

    def text(value)
      @__buffer << ERB::Escape.html_escape(value)
      self
    end

    def attr(&blk)
      if blk
        Attribute.new(&blk)
      else
        Attribute.new
      end
    end

    def comment(comment_text = nil)
      write('<!--', '-->', nil, closing_char: '') { text comment_text.to_s }
    end

    def doctype
      @__buffer << '<!DOCTYPE html>'
      self
    end

    def script(attributes = nil, &block) # rubocop:disable Lint/UnusedMethodArgument
      body = yield
      write('<script', '</script>', attributes) { send :unsafe_text, body }
    end

    # join an array of other templates into this template.
    def join(templates)
      templates.each { @__buffer << _1.render }
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
      @__buffer << value
      self
    end

    CLOSE = '>'
    CLOSE_VOID = '/>'

    def write(open, close, attr = nil, closing_char: CLOSE, &block)
      @__buffer << open << Attribute.to_html(attr)

      @__buffer << closing_char
      yield self if block
      @__buffer << close

      self
    end

    def write_void(open, attr = nil)
      @__buffer << open << Attribute.to_html(attr) << CLOSE_VOID
    end
  end
end
