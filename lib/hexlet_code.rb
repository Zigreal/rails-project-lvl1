# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end
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
          result << " #{k}='#{v}'"
        end.join
      end
    end
  end
end
