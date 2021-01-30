# frozen_string_literal: true

module Mutations
  class RemoveFavouriteRecipeMutation < BaseMutation
    argument :id, ID, required: true

    field :recipe, Types::RecipeType, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(id:)
      recipe = Recipe.find(id)
      authorize(recipe, :favourite?)

      case RemoveFavouriteRecipeForm.perform(user: current_user, recipe: recipe)
      in Recipe => recipe
        { recipe: recipe }
      in ActiveModel::Errors => errors
        { errors: errors }
      end
    end
  end
end
