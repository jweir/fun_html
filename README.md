# Fun HTML

A simple Ruby HTML template engine. Its goals are to be simple, performant,
typed, and use only the standard library.

Sorbet typing is optionally supported. 

```
gem install fun_html
```

Example

```ruby
require_relative 'lib/fun_html'

class Template < FunHtml::Template
  def call(items)
    doctype
    html(attr.lang('en')) do
      head do
        title { text "Fun HTML" }
      end
      body do
        h1(attr.id('one')) { text "Title" }
        items.each do |item|
          div { a(attr.href(item.url)) { text item.name }}
        end
      end
    end
  end
end

Item = Struct.new :name, :url

puts Template.new.call([Item.new('About', '/about'), Item.new('Home', '/')]).render
# => <!DOCTYPE html><html lang="en"><head><title>Fun HTML</title></head><body><h1 id="one">Title</h1><div><a href="/about">About</a></div><div><a href="/">Home</a></div></body></html>
```

## Rails integration

This library will not have any Rails support builtin, but it is not difficult to support. 

```
class RailsView < FunHtml::Template
  extend T::Sig

  sig { params(view_context: ActionView::Base).returns(String) }
  def render_in(view_context)
    view_context.render html: render!
  end

  sig { returns(String) }
  def render!
    render.html_safe # it is up to you to ensure that this is html_safe
  end
end
```

The you can `render` the object:

```
render MySubClassOfRailsView.new(my_data)
```

## Escape Hatch

This is Ruby so you can do whatever you want in the runtime and there is no saftey.

So if you want to bring in things like Rails helpers, or other libraries, you
can always write directly to the template's buffer or replace the render method
on a subclassed template. Its all just a string at the core.

## TODO
* Is having one large string ideal? There is no line breaking of any type.
* Support SVG
* Check the `data` and `attribute` properties for possible injection

## Node?

The node related code is present to generate the HTML element specs.
