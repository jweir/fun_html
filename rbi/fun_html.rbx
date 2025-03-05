# typed: true
# frozen_string_literal: true

module FunHtml
  class Template
    include FunHtml::Writer
    include FunHtml::SpecElements::HTMLAllElements

    sig { params(block: T.proc.params(arg0: T.attached_class).void).returns(T.attached_class) }
    def self.start(&block); end

    sig { params(templates: T::Array[FunHtml::Writer]).returns(T.self_type) }
    def join(templates); end

    sig do
      params(blk: T.nilable(T.proc.params(arg0: FunHtml::Attribute).void)).returns(FunHtml::Attribute)
    end
    def attr(&blk); end

    sig { params(value: String).returns(T.self_type) }
    def text(value); end

    sig { returns(T.self_type) }
    def doctype; end

    sig do
      params(attributes: T.nilable(FunHtml::Attribute),
             block: T.proc.returns(String)).returns(T.self_type)
    end
    def script(attributes, &block); end

    sig { params(comment_text: T.nilable(String)).returns(T.self_type) }
    def comment(comment_text = nil); end
  end

  module Writer
    sig { void }
    def initialize
      @__buffer = T.let(+'', String)
    end

    sig { params(value: String).returns(T.self_type) }
    def unsafe_text(value); end

    sig { returns(String) }
    def render; end

    private

    sig do
      params(open: String, close: String, attr: T.nilable(FunHtml::Attribute), closing_char: String,
             block: T.nilable(T.proc.params(arg0: FunHtml::Writer).void)).returns(T.self_type)
    end
    def write(open, close, attr = nil, closing_char: CLOSE, &block); end

    sig { params(open: String, attr: T.nilable(FunHtml::Attribute)).void }
    def write_void(open, attr = nil); end
  end

  class Attribute
    extend T::Sig

    sig do
      params(buffer: T::Hash[String, T.untyped], block: T.nilable(T.proc.params(arg0: FunHtml::Attribute).void)).void
    end
    def initialize(buffer = {}, &block) # rubocop:disable Lint/UnusedMethodArgument
      @__buffer = buffer
    end

    sig { params(suffix: String, value: String).returns(FunHtml::Attribute) }
    def data(suffix, value); end

    sig { params(value: String).returns(FunHtml::Attribute) }
    def klass(value); end

    sig { params(attr: T.nilable(FunHtml::Attribute)).returns(String) }
    def self.to_html(attr); end

    sig { params(list: T::Hash[String, T::Boolean]).returns(FunHtml::Attribute) }
    def classes(list); end

    sig { params(list: T::Hash[String, T::Boolean]).returns(FunHtml::Attribute) }
    def klasses(list); end

    sig { params(other: FunHtml::Attribute).returns(FunHtml::Attribute) }
    def merge(other); end

    sig { returns(String) }
    def safe_attribute; end

    sig { params(name: String, value: T.untyped).returns(FunHtml::Attribute) }
    def write(name, value); end

    sig { params(name: String, print: T::Boolean).returns(FunHtml::Attribute) }
    def write_boolean(name, print); end

    include FunHtml::SpecAttributes
  end
end
