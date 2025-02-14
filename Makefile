default:
	find . -name "*.rb" | entr bundle exec rake

bench:
	find . -name "*.rb" | entr ruby test/bench.rb

update:
	bin/tapioca annotations
	bin/tapioca gem --all
	bundle exec tapioca dsl
	bin/tapioca todo

generate:
	ruby -r ./generators/elements.rb -e 'Generators::Elements.call'
	ruby -r ./generators/attributes.rb -e 'Generators::Attributes.call'
	cat rbi/fun_html.rbx rbi/elements.rbx rbi/attributes.rbx > rbi/fun_html.rbi
	rubocop -A lib/fun_html/spec_elements.rb lib/fun_html/spec_attributes.rb rbi/**

build:
	rm *.gem
	gem build
	cp *.gem ../../pharos-ei/ams
