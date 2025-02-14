# typed: strict

require_relative 'attribute'
require_relative 'writer'
require 'erb/escape'

module FunHtml
  # nodoc
  class Template
    include FunHtml::Writer
    include FunHtml::SpecElements::HTMLAllElements

    def self.start(&block)
      obj = new
      yield obj if block
      obj
    end

    def text(value)
      @__buffer << ERB::Escape.html_escape(value)
      self
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

    def attr(&blk)
      if blk
        Attribute.new(&blk)
      else
        Attribute.new
      end
    end
  end
end
