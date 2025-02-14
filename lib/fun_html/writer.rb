# typed: strict
# frozen_string_literal: true

require_relative 'spec_elements'
require 'erb/escape'

module FunHtml
  # nodoc
  module Writer
    include Kernel

    def initialize
      @__buffer = +''
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
