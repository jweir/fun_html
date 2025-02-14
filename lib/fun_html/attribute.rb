# typed: strict
# frozen_string_literal: true

require_relative 'spec_attributes'
require 'erb/escape'

module FunHtml
  # Attribute generates HTML attributes. It is designed to prevent printing the
  # same attribute twice. The Template elements expect an Attribute object.
  #
  # All attribute values are HTML escaped via ERB::Escape.
  #
  # It is typed to only allow the correct types to be passed to the attribute,
  # if Sorbet is enabled.
  #
  # Attributes can be generated via a block, or chained.
  #
  # Block
  #     Attribute.new { _1.id "one" ; _1.klass "big" }
  #
  # Chained
  #     Attribute.new.id("one").klass("big")
  #
  # Boolean attributes
  # Some attributes (async, autoplay, disabled) are boolean.  When true is
  # passed, the attribute prints, when false, the attribute will be blank.
  #
  # Attribute.new.disabled(true) -> " disabled"
  # Attribute.new.disabled(false) -> " "
  class Attribute
    include FunHtml::SpecAttributes

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

    # Custom data attributes
    # The data attribute takes a suffix and the string value.
    # Attribute.new.data('turbo','false') -> ' data-turbo="false"'
    def data(suffix, value)
      unless suffix.match?(/\A[a-z-]+\z/)
        raise ArgumentError,
              "suffix (#{suffix}) must be lowercase and only contain 'a' to 'z' or hyphens."
      end

      write(" data-#{suffix}=\"", value)
    end

    # CSS class name(s) for styling, the name changed to protect the Ruby.
    def klass(value)
      write(' class="', value)
    end

    # Merge another Attribute to create a new, combined, Attribute.
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

    # for boolean attributes, determin if to print the attribute or not
    def write_boolean(name, print)
      @__buffer[name] = print ? name : ''
      self
    end
  end
end
