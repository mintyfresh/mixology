# frozen_string_literal: true

module Mutations
  class AddFavouriteRecipeMutation < BaseMutation
    argument :id, ID, required: true

    field :recipe, Types::RecipeType, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(id:)
      recipe = Recipe.find(id)
      authorize(recipe, :favourite?)

      case (result = AddFavouriteRecipeForm.perform(user: current_user, recipe: recipe))
      when Recipe
        { recipe: result }
      when ActiveModel::Errors
        { errors: result }
      end
    end
  end
end
