# frozen_string_literal: true

module HexletCode
  module FormRender
    # генерирует html для submit
    module Submit
      class << self
        def call(submit_state)
          Tag.build(
            'input',
            **{
              type: 'submit',
              name: 'commit',
              value: submit_state.fetch(:name, 'Save'),
              **submit_state
            }
          )
        end
      end
    end
  end
end
