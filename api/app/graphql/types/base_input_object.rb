# frozen_string_literal: true

module Types
  class BaseInputObject < GraphQL::Schema::InputObject
    argument_class Types::BaseArgument

    # @param attributes [Hash]
    # @param context [GraphQL::Query::Context, nil]
    # @param defaults_used [Set]
    # @return [BaseInputObject]
    def self.build_from_attributes(attributes, context: nil, defaults_used: Set.new)
      to_graphql

      attributes = attributes.transform_keys { |key| key.to_s.camelize(:lower) }
      arguments  = arguments_class.new(attributes, context: context, defaults_used: defaults_used)

      new(ruby_kwargs: arguments.to_kwargs, context: context, defaults_used: defaults_used)
    end
  end
end
