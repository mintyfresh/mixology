# frozen_string_literal: true

module Types
  class UserType < BaseObject
    field :id, ID, null: false
    field :display_name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false

    field :authored_recipes, RecipeType.connection_type, null: false
    field :favourited_recipes, RecipeType.connection_type, null: false
  end
end
