# frozen_string_literal: true

class Rspec
  class FormGenerator < Rails::Generators::NamedBase
    CLASS_NAME_SUFFIX = 'Form'
    FILE_NAME_SUFFIX  = '_form'

    source_root File.expand_path('templates', __dir__)

    def create_form_spec
      template('form_spec.rb.erb', form_spec_file_path)
    end

    hook_for :fixture_replacement, as: :input_factory

  private

    # @return [String]
    def form_class_name
      name.camelize.chomp(CLASS_NAME_SUFFIX) + CLASS_NAME_SUFFIX
    end

    # @return [String]
    def input_factory_name
      "#{name.underscore.chomp(FILE_NAME_SUFFIX)}_input"
    end

    # @return [String]
    def form_spec_file_name
      "#{name.underscore.chomp(FILE_NAME_SUFFIX)}#{FILE_NAME_SUFFIX}_spec.rb"
    end

    # @return [String]
    def form_spec_file_path
      File.join('spec', 'forms', form_spec_file_name)
    end
  end
end
