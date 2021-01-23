# frozen_string_literal: true

module FactoryBot
  class InputFactoryGenerator < Rails::Generators::NamedBase
    INPUT_FACTORY_NAME_PREFIX = '_input'

    source_root File.expand_path('templates', __dir__)

    def create_input_factory
      template('inputs.rb.erb', input_factory_file_path)
    end

  private

    # @return [String]
    def input_factory_name
      name.underscore.chomp(INPUT_FACTORY_NAME_PREFIX) + INPUT_FACTORY_NAME_PREFIX
    end

    # @return [String]
    def input_factory_file_name
      "#{input_factory_name.pluralize}.rb"
    end

    # @return [String]
    def graphql_input_class_name
      "Types::#{input_factory_name.camelize}Type"
    end

    # @return [String]
    def input_factory_file_path
      File.join('spec', 'factories', 'inputs', input_factory_file_name)
    end
  end
end
