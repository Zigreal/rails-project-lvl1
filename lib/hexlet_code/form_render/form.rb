# frozen_string_literal: true

module HexletCode
  # :nodoc
  module FormRender
    autoload :Input, 'hexlet_code/form_render/input'
    autoload :Submit, 'hexlet_code/form_render/submit'

    # генерирует html формы
    module Form
      class << self
        def call(form_state)
          action = form_state[:attrs].fetch(:url, '#')
          Tag.build('form', **{ action: action, method: 'post', **form_state[:attrs].except(:url) }) do
            form_state[:elements_states].map do |element_state|
              HexletCode::FormRender.const_get(element_state[:type]).call(element_state[:attrs])
            end.join
          end
        end
      end
    end
  end
end
