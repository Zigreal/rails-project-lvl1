# frozen_string_literal: true

module HexletCode
  # строит стэйт формы
  class FormBuilder
    attr_reader :form_object, :form_state

    def initialize(form_object, **form_attrs)
      @form_object = form_object
      @form_state = { attrs: form_attrs, elements_states: [] }
    end

    def input(name, **options)
      form_state[:elements_states] << new_element_state(name, options)
    end

    def submit(value = 'Save', **options)
      form_state[:elements_states] << { type: :Submit, attrs: { value: value, **options } }
    end

    private

    def new_element_state(name, options)
      { type: :Input, attrs: { **options, name: name, value: form_object.public_send(name) } }
    end
  end
end
