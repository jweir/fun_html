# frozen_string_literal: true

require 'json'

module Generators
  # generates the HTML node definitions
  # https://html.spec.whatwg.org/multipage/syntax.html#void-elements
  module Elements
    VOID = %w[area base br col embed hr img input link meta source track wbr].freeze

    def self.call
      source = File.read 'node_modules/@webref/elements/html.json'
      grouped = JSON.parse(source)['elements'].group_by { _1['interface'] }

      interfaces = grouped.transform_values do |elements|
        elements.map do |el|
          name = el['name']

          if VOID.include?(name)
            void_element(name)
          else
            element(name)
          end
        end
      end

      signatures = grouped.transform_values do |elements|
        elements.map do |el|
          name = el['name']
          sig_element(name)
        end
      end

      File.write 'lib/fun_html/node_definitions.rb', template(interfaces)
      File.write 'rbi/node_definitions.rbx', template(signatures)
    end

    def self.template(interfaces)
      <<~SRC
        module FunHtml
          # HTML nodes autogenerated, do not edit
          module NodeDefinitions
            #{interfaces.map do |interface, elements|
              <<~HTML
                module #{interface}
                #{elements.join("\n\n")}
                end
              HTML
            end.join("\n\n")}

            module HTMLAllElements
            #{interfaces.keys.map do |interface|
              <<~HTML
                include #{interface}
              HTML
            end.join
            }
            end
          end
        end
      SRC
    end

    def self.void_element(name)
      <<~SRC
        def #{name}(attributes = nil, &elements)
          # no child elements allowed and no closing tag
          write('<#{name}', '>', attributes)
        end
      SRC
    end

    def self.sig_element(name)
      <<~SRC
        sig {params(attributes: T.nilable(FunHtml::Attribute), elements: T.nilable(T.proc.bind(FunHtml::Template).void)).returns(T.self_type) }
        def #{name}(attributes = nil, &elements); end
      SRC
    end

    def self.element(name)
      <<~SRC
        def #{name}(attributes = nil, &elements)
          write('<#{name}', '</#{name}>', attributes, &elements)
        end
      SRC
    end
  end
end