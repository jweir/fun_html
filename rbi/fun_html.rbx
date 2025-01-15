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

    sig { params(blk: T.proc.bind(FunHtml::Attribute).void).returns(FunHtml::Attribute) }
    def attr(&blk); end
    def comments(&elements); end

    sig { returns(T.self_type) }
    def doctype; end

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

    sig { params(buffer: T::Hash[T.untyped, T.untyped], block: T.nilable(T.proc.bind(FunHtml::Attribute).void)).void }
    def initialize(buffer = {}, &block); end
  end
end
