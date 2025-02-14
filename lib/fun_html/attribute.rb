# typed: strict
# frozen_string_literal: true

require_relative 'spec_attributes'
require 'erb/escape'

module FunHtml
  # Create html attributes.
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
