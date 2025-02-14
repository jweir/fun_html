# typed: strict

require_relative 'attribute'
require_relative 'writer'
require 'erb/escape'

module FunHtml
  # FunHtml Template will generate typed HTML. Each tag and attribute has a
  # match method that is typed via Sorbet (which is optional).
  #
  #
  # If you need to create custom tags, create a method that integrates with the Writer#write method.
  class Template
    include FunHtml::Writer
    include FunHtml::SpecElements::HTMLAllElements

    # To avoid subclassing a template, `start` can be used to yeild and return a Template.
    #
    #     html = FunHtml::Template.start do |t|
    #       t.doctype
    #       t.html do
    #         t.body { t.h1 "Body" }
    #       end
    #     end
    #
    def self.start(&block)
      obj = new
      yield obj if block
      obj
    end

    # text will generate the text node, this is the only way to insert strings into the template.
    #
    #     Template.start do |t|
    #       t.div { t.text  "Hello" }
    #     end
    #
    def text(value)
      @__buffer << ERB::Escape.html_escape(value)
      self
    end

    # generate a comment block
    def comment(comment_text = nil)
      write('<!--', '-->', nil, closing_char: '') { text comment_text.to_s }
    end

    # generate the doctype
    def doctype
      @__buffer << '<!DOCTYPE html>'
      self
    end

    # generate a script tag. The return the script code to the block.
    # The code is not escaped.
    def script(attributes = nil, &block) # rubocop:disable Lint/UnusedMethodArgument
      body = yield
      write('<script', '</script>', attributes) { send :unsafe_text, body }
    end

    # attr is short cut in the template to return a new Attribute
    #
    # Template.start { |t| t.div(t.attr.id('my-div'), t.text '...') }
    def attr(&blk)
      if blk
        Attribute.new(&blk)
      else
        Attribute.new
      end
    end
  end
end
