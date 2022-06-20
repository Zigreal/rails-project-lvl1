# frozen_string_literal: true

# Генерирует форму
module HexletCode
  autoload :Tag, 'hexlet_code/tag'
  autoload :FormBuilder, 'hexlet_code/form_builder'
  autoload :FormRender, 'hexlet_code/form_render/form'
  class << self
    def form_for(form_object, **options)
      form = FormBuilder.new(form_object, **options)
      yield form if block_given?
      FormRender::Form.call(form.form_state)
    end
  end
end
