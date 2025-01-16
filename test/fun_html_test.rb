# typed: true
# frozen_string_literal: true

require './lib/fun_html'
require 'minitest/autorun'
require 'minitest/spec'

class FunHtmlTest < Minitest::Test
  extend Minitest::Spec::DSL

  Item = Struct.new(:name)
  A = FunHtml::Attribute

  class X < FunHtml::Template
    def call(item)
      h1(A.new do |a|
        a.id('big')
        a.klass('a "b" c')
      end) do
        text(item.name)
        br
        b { text('Hello & good "byte"') }
      end
    end
  end

  class Y < FunHtml::Template
    def call(item)
      o = item.name
      div(attr do |a|
        a.id(o)
        a.disabled(true)
      end) { text item.name }
    end
  end

  class Z < FunHtml::Template
    def initialize
      @value = 'Z'
      super
    end

    def call
      h1 { text @value }
    end
  end

  # TODO: only support strings in comments
  specify 'comments supported' do
    assert_equal '<p><!--no comment--></p>', FunHtml::Template.new.p { comment { text 'no comment' } }.render
    assert_equal '<p><!----></p>', FunHtml::Template.new.p { comment }.render, 'empty comment'
  end

  specify 'doctype supported' do
    template = FunHtml::Template.new
    template.doctype
    assert_equal '<!DOCTYPE html>', template.render
  end

  specify 'renders HTML and attributes' do
    assert_equal \
      '<h1 id="big" class="a &quot;b&quot; c">ITEM<br/><b>Hello &amp; good &quot;byte&quot;</b></h1>',
      X.new.call(Item.new('ITEM')).render
  end

  specify 'does not double render' do
    t = Z.new
    t.call.render
    result = t.call.render
    assert_equal '<h1>Z</h1>', result
  end

  specify 'handles whitespace correctly' do
    t = FunHtml::Template.new.html do
      text(
        <<~TXT
          Hello,

          My name is Joe.
          Bye.
        TXT
      )
    end

    assert_equal "<html>Hello,\n\nMy name is Joe.\nBye.\n</html>", t.render
  end

  specify 'supports appending and binding' do
    t = FunHtml::Template.new
    value = 'ok' # this would be bound to the block
    @value = 'not_present' # this should not be bound
    t.h1 { b { text(value) } }
    t.span { text(@value) }
    assert_equal '<h1><b>ok</b></h1><span></span>', t.render
  end

  specify 'a template can be included into another' do
    b = FunHtml::Template.new.div { text 'B' }
    a = FunHtml::Template.new.html do
      div { text 'A' }
      include(b)
    end

    assert_equal '<html><div>A</div><div>B</div></html>', a.render
  end

  specify 'does not require a block' do
    assert_equal \
      '<title title="Ok"/>',
      FunHtml::Template.new.title(A.new { |a| a.title 'Ok' }).render
  end

  specify 'text is html escaped' do
    t = FunHtml::Template.new
    assert_equal '&lt;script&gt;x&lt;/script&gt;', t.text('<script>x</script>').render
  end

  specify 'unsafe_text is not html escaped' do
    t = FunHtml::Template.new
    assert_equal "<script>'x'</script>", t.unsafe_text("<script>'x'</script>").render
  end

  specify 'the data attibutes requires the name portion' do
    assert_equal(' data-abc-def="ok"', FunHtml::Attribute.new { |a| a.data('abc-def', 'ok') }.safe_attribute)

    assert_raises do
      FunHtml::Attribute.new { |a| a.data('abc:def', 'ok') }.safe_attribute
    end
  end

  specify 'attributes are supported' do
    a = FunHtml::Attribute.new do |a|
      a.klass('ok')
      a.id('1')
    end

    b = FunHtml::Attribute.new { |a| a.name('foo') }

    c = a.merge(b)

    assert_equal 'class="ok" id="1"', a.safe_attribute.strip
    assert_equal 'name="foo"', b.safe_attribute.strip
    assert_equal 'class="ok" id="1" name="foo"', c.safe_attribute.strip
  end

  specify 'attributes do not allow attributes to defined more than once' do
    a = FunHtml::Attribute.new do |a|
      a.id('one')
      a.name('ok')
      a.id('"two"')
    end
    c = a.merge(FunHtml::Attribute.new { |a| a.id('three') })
    assert_equal ' id="&quot;two&quot;" name="ok"', a.safe_attribute
    assert_equal ' id="three" name="ok"', c.safe_attribute
  end

  specify 'support valueless attributes' do
    a = FunHtml::Attribute.new { |a| a.disabled(true) }
    b = a.merge(FunHtml::Attribute.new { |a| a.disabled(false) })
    assert_equal ' disabled', a.safe_attribute
    assert_equal '', b.safe_attribute
  end

  # Threads
  it 'is thread safe' do
    100.times do
      thread_safety
    end
  end

  def thread_safety
    # This will store the outputs generated by each thread
    outputs = []

    # Create a number of threads and generate HTML in each one
    threads = 5.times.map do |n|
      Thread.new do
        outputs << FunHtml::Attribute.new do |a|
          sleep 0.01 if [1].include?(n)
          a.id n.to_s
          a.klass n.to_s
          a.rel n.to_s
        end
      end
    end

    # Wait for all threads to complete
    threads.each(&:join)

    expected = <<~STYLE
      id="0" class="0" rel="0"
      id="1" class="1" rel="1"
      id="2" class="2" rel="2"
      id="3" class="3" rel="3"
      id="4" class="4" rel="4"
    STYLE

    assert_equal expected.strip, outputs.map(&:safe_attribute).sort.map(&:strip).join("\n").strip
  end
end

# set of OpenAI generated tests
class FunHtmlTemplateTest < Minitest::Test
  A = FunHtml::Attribute
  def setup
    @template = FunHtml::Template.new
  end

  def test_text_sanitization
    unsafe_string = "<script>alert('XSS');</script>"
    @template.text(unsafe_string)
    assert_equal '&lt;script&gt;alert(&#39;XSS&#39;);&lt;/script&gt;', @template.render
  end

  def test_void_elements
    r = FunHtml::Template.new.html do
      br
      hr
      img(A.new { |a| a.href '/image' })
    end

    assert_equal '<html><br/><hr/><img href="/image"/></html>', r.render
  end

  def test_html_node_creation
    @template.html do
      head do
        title { text 'My Page Title' }
      end
      body do
        h1 { text 'Heading' }
        p { text 'This is a paragraph.' }
      end
    end
    expected_output = '<html><head><title>My Page Title</title></head><body><h1>Heading</h1><p>This is a paragraph.</p></body></html>'
    assert_equal expected_output, @template.render
  end

  def test_attribute_sanitization
    @template.a(A.new { |a| a.href "javascript:alert('XSS')" }) { text 'Click me' }
    assert_match(/href="javascript:alert\(&#39;XSS&#39;\)"/, @template.render)
  end

  def test_attribute_quoting
    @template.p(A.new { |a| a.klass 'class"with"quotes' }) { text 'Test' }
    assert_match(/class="class&quot;with&quot;quotes"/, @template.render)
  end

  def test_self_closing_tags
    @template.img(A.new { |a| a.src('image.png') && a.alt('An image') })
    assert_match(%r{<img src="image.png" alt="An image"/>}, @template.render)
  end

  def test_invalid_html_escaping
    @template.text('<html><body>Invalid HTML</body></html>')
    assert_equal '&lt;html&gt;&lt;body&gt;Invalid HTML&lt;/body&gt;&lt;/html&gt;', @template.render
  end

  def test_script_tag_escaping
    @template.script { text "console.log('Hello, World!');" }
    assert_equal '<script>console.log(&#39;Hello, World!&#39;);</script>', @template.render
  end

  def test_only_allows_attributes
    assert_raises do
      @template.p(klass: 'my-class') { text 'Test' }
      @template.render
    end
  end

  def test_attribute_method_aliasing
    @template.p(A.new { |a| a.klass 'my-class' }) { text 'Test' }
    assert_match(/class="my-class"/, @template.render)
  end

  def test_html_structure
    @template.html do
      body do
        div(A.new { |a| a.id 'main' }) do
          p { text 'Nested content' }
        end
      end
    end
    expected_structure = '<html><body><div id="main"><p>Nested content</p></div></body></html>'
    assert_equal expected_structure, @template.render
  end
end
