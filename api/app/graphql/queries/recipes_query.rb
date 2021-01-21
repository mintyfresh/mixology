# frozen_string_literal: true

module Queries
  class RecipesQuery < BaseQuery
    type Types::RecipeType.connection_type, null: false

    def resolve
      policy_scope(Recipe.all).order(:id)
    end
  end
end
