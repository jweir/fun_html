# typed: strict
# frozen_string_literal: true

require_relative 'spec_elements'
require 'erb/escape'

module FunHtml
  # Writer collects the rendered elements and attributes into a string.
  module Writer
    include Kernel

    def initialize
      @__buffer = +''
    end

    # Render produces the HTML string and clears the buffer.
    def render
      @__buffer
    ensure
      # empty the buffer to prevent double rendering
      @__buffer = +''
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
