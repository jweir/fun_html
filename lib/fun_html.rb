# typed: strict
# frozen_string_literal: true

require_relative 'fun_html/attribute'
require_relative 'fun_html/writer'
require 'erb/escape'

# nodoc
module FunHtml
  # nodoc
  class Template
    include FunHtml::Writer
    include FunHtml::NodeDefinitions::HTMLAllElements

    def self.start(&block)
      obj = new
      yield obj if block
      obj
    end
  end
end
