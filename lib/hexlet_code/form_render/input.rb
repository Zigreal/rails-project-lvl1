# frozen_string_literal: true

module HexletCode
  module FormRender
    # генерирует html для input
    module Input
      class << self
        def call(input_state)
          label = Tag.build('label', for: input_state[:name]) { input_state[:name].capitalize }
          input = if input_state.fetch(:as, :input) == :text
                    build_textarea(input_state)
                  else
                    build_input(input_state)
                  end

          "#{label}#{input}"
        end

        private

        def build_input(input_state)
          Tag.build('input', **{ type: 'text', **input_state })
        end

        def build_textarea(input_state)
          Tag.build('textarea', **{ cols: 20, rows: 40, **input_state.except(:as, :value) }) { input_state[:value] }
        end
      end
    end
  end
end
