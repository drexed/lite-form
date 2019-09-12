# frozen_string_literal: true

require 'rails/generators'

module Rails
  class FormGenerator < Rails::Generators::NamedBase

    source_root File.expand_path('../templates', __FILE__)
    check_class_collision suffix: 'Form'

    def copy_files
      path = File.join('app', 'forms', class_path, "#{file_name}_form.rb")
      empty_directory('app/forms')
      template('form.rb.tt', path)
    end

    def copy_specs
      path = File.join('spec', 'forms', class_path, "#{file_name}_form_spec.rb")
      empty_directory('spec/forms')
      template('spec.rb.tt', path)
    end

    private

    def file_name
      @_file_name ||= remove_possible_suffix(super)
    end

    def remove_possible_suffix(name)
      name.sub(/_?form$/i, '')
    end

  end
end
