# typed: true

require_relative('../lib/fun_html')

a = FunHtml::Attribute.new

a.disabled true

FunHtml::Attribute.new do |b|
  b.id('big')
  b.klass('a "b" c')
end

class Z < FunHtml::Template
  def my_path
    'asdf'
  end
end

@html_a = Z.start do |t|
  t.head do
    t.title { t.text 'My Page Title' }
    t.title { t.text t.my_path }
  end
  t.body do
    t.h1 { t.text 'Heading' }
    t.p { t.text 'This is a paragraph.' }
  end
end

@html_b = Z.start do |t|
  t.div do
    t.text 'inserted'
  end
end

@html_a.join([@html_b])

class Template < FunHtml::Template
  extend T::Sig

  sig { returns(Template) }
  def test
    doctype
  end

  sig { params(items: T::Array[Item]).returns(FunHtml::Template) }
  def call(items)
    FunHtml::Attribute.new do |a|
      a.lang('en')
    end

    doctype

    html(attr do |a|
           a.lang('en')
           a.max('en')
         end) do
      head do
        title { text 'Fun HTML' }
        script(attr { |a| a.id 'test_script' }) { 'hello' }
      end
      body do
        h1(attr { _1.id('one') }) { text 'Title' }
        items.each do |item|
          div { a(attr { _1.href(item.url) }) { text item.name } }
        end
      end
    end
  end
end

Item = Struct.new :name, :url

puts Template.new.call([Item.new('About', '/about'), Item.new('Home', '/')]).render
