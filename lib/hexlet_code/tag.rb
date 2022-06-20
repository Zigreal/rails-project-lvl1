# frozen_string_literal: true

module HexletCode
  # Генерирует html-теги
  class Tag
    SINGLE_TAGS =
      %w[!doctype area base br col embed hr img input
         keygen link meta param source track wbr].freeze

    class << self
      def build(tag, **options)
        if SINGLE_TAGS.include?(tag)
          "<#{tag}#{build_attributes(options)}>"
        else
          "<#{tag}#{build_attributes(options)}>#{yield if block_given?}</#{tag}>"
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
