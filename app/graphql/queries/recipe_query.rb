# frozen_string_literal: true

module Queries
  class RecipeQuery < BaseQuery
    type Types::RecipeType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      recipe = Recipe.find(id)
      authorize(recipe, :show?)

      recipe
    end
  end
end
