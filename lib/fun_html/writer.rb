# typed: strict
# frozen_string_literal: true

require_relative 'spec_elements'
require 'erb/escape'

module FunHtml
  # Writer collects the rendered elements and attributes into a string.
  module Writer
    include Kernel

    def initialize
      @__buffer = String.new(capacity: 1024)
    end

    # Render produces the HTML string and clears the buffer.
    def render
      result = @__buffer
      # empty the buffer to prevent double rendering
      @__buffer = String.new(capacity: 1024)
      result
    end

    private

    # used when the text should not be escaped, see `script`
    def unsafe_text(value)
      @__buffer << value
      self
    end

    CLOSE = '>'
    CLOSE_VOID = '/>'

    def write(open, close, attr = nil, closing_char: CLOSE, &block)
      if attr
        @__buffer << open << Attribute.to_html(attr) << closing_char
      else
        @__buffer << open << closing_char
      end

      yield self if block
      @__buffer << close

      self
    end

    def write_void(open, attr = nil)
      @__buffer << open << Attribute.to_html(attr) << CLOSE_VOID
    end
  end
end
