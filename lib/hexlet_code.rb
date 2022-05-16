# frozen_string_literal: true

# Генерирует форму
module HexletCode
  class << self
    def form_for(object, url: nil)
      "<form action=\"#{url || "#"}\" method=\"post\">#{yield(FormBuilder.new(object)) if block_given?}</form>"
    end
  end

  # Генерирует поля формы
  class FormBuilder
    attr_accessor :object, :output

    def initialize(object)
      @object = object
      @output = []
    end

    def input(attr_name, **options)
      output.tap do |output|
        output << HexletCode::Tag.build("label", for: attr_name) { attr_name.capitalize }
        output << if options.delete(:as).to_s == "text"
                    Tag.build("textarea", cols: 20, rows: 40, name: attr_name) { object.public_send(attr_name) }
                  else
                    Tag.build("input", name: attr_name, type: "text", value: object.public_send(attr_name), **options)
                  end
      end.join
    end

    def submit
      output.tap do |output|
        output << Tag.build("input", name: "commit", type: "submit", value: "Save")
      end.join
    end
  end

  class Error < StandardError; end

  # Генерирует html-тэги
  class Tag
    autoload :ERB, "erb"
    SINGLE_TAGS =
      %w[!doctype area base br col embed hr img input
         keygen link meta param source track wbr].freeze

    class << self
      def build(tag, **attributes)
        if SINGLE_TAGS.include?(tag)
          "<#{tag}#{build_attributes(attributes)}>"
        else
          "<#{tag}#{build_attributes(attributes)}>#{yield if block_given?}</#{tag}>"
        end
      end

      private

      def build_attributes(attributes)
        attributes.each_with_object([]) do |(k, v), result|
          result << ERB::Util.h(" #{k}=\"#{v}\"")
        end.join
      end
    end
  end
end
