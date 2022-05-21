# frozen_string_literal: true

# Генерирует форму
module HexletCode
  class << self
    def form_for(object, url: nil)
      "<form action=\"#{url || '#'}\" method=\"post\">#{yield(FormBuilder.new(object)) if block_given?}</form>"
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
        output << HexletCode::Tag.build('label', for: attr_name) { attr_name.capitalize }
        output << build_input_or_textarea(attr_name, options)
      end.join
    end

    def submit(button_text = 'Save')
      output.tap do |output|
        output << Tag.build('input', name: 'commit', type: 'submit', value: button_text)
      end.join
    end

    private

    def build_input_or_textarea(attr_name, options)
      if options.delete(:as).to_s == 'text'
        Tag.build('textarea', cols: options[:cols] || 20, rows: options[:rows] || 40, name: attr_name) do
          object.public_send(attr_name)
        end
      else
        Tag.build('input', name: attr_name, type: 'text', value: object.public_send(attr_name), **options)
      end
    end
  end

  # Генерирует html-тэги
  class Tag
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
          result << " #{k}=\"#{v}\""
        end.join
      end
    end
  end
end
