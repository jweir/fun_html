# frozen_string_literal: true

require './lib/fun_html'
require 'benchmark/ips'

class Layout < FunHtml::Template
  A = FunHtml::Attribute

  def call
    title(attr { _1.title('Example') })
    meta(attr do |a|
      a.name('viewport')
      a.content('width=device-width,initial-scale=1')
    end)
    link(attr do |a|
      a.href('/assets/tailwind.css')
      a.rel('stylesheet')
    end)
    body(attr { _1.klass('bg-zinc-100') }) do
      nav(
        attr do |a|
          a.klass('p-5')
          a.id('main_nav')
        end
      ) do
        attr = A.new
        attr.klass 'p-5'

        ul do
          li(attr) { a(attr { _1.href('/') }) { text('Home') } }
          li(attr) { a(attr { _1.href('/about') }) { text('About') } }
          li(attr) { a(attr { _1.href('/contact') }) { text('Concat') } }
        end
      end

      h1 { text('Hi') }

      attr = A.new
      attr.id('test1')
      attr.id('a')

      table(A.new { _1.id('test') }) do
        tr do
          td(attr) { span { text('Hi') } }
          td(attr) { span { text('Hi') } }
          td(attr) { span { text('Hi') } }
          td(attr) { span { text('Hi') } }
          td(attr) { span { text('Hi') } }
        end
      end
    end
  end
end

class HtmlBenchmark
  include FunHtml
  A = FunHtml::Attribute

  def template
    Layout.new.call.render
  end
end

Benchmark.ips do |x|
  x.report('Page', -> { HtmlBenchmark.new.template })
end
