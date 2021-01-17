# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    include GraphQLContext

    argument_class Types::BaseArgument
    field_class Types::BaseField
    object_class Types::BaseObject
  end
end
