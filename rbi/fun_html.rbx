# typed: true
# frozen_string_literal: true

module FunHtml
  class Template
    include FunHtml::Writer
    include FunHtml::NodeDefinitions::HTMLAllElements
  end

  module Writer
    sig { params(value: String).returns(T.self_type) }
    def text(value); end

    sig { params(value: String).returns(T.self_type) }
    def unsafe_text(value); end

    sig do
      params(blk: T.proc.params(arg0: FunHtml::Attribute).void).returns(FunHtml::Attribute)
    end
    def attr(&blk); end

    sig { params(text: T.nilable(String)).returns(T.self_type) }
    def comments(text); end

    sig { params(template: FunHtml::Template).returns(T.self_type) }
    def include(template); end

    sig { returns(T.self_type) }
    def doctype; end

    sig do
      params(attributes: T.nilable(FunHtml::Attribute),
             block: T.proc.params(arg0: String).void).returns(T.self_type)
    end
    def script(attributes, &blk); end

    sig { returns(String) }
    def render; end
  end

  class Attribute
    extend T::Sig
    sig { params(attr: FunHtml::Attribute).returns(String) }
    def self.to_html(attr); end

    sig { params(other: FunHtml::Attribute).returns(FunHtml::Attribute) }
    def merge(other); end

    include FunHtml::AttributeDefinitions
    sig do
      params(buffer: T::Hash[T.untyped, T.untyped],
             block: T.nilable(T.proc.params(arg0: FunHtml::Attribute).void)).void
    end
    def initialize(buffer = {}, &block); end
  end
end
