# frozen_string_literal: true

module Mutations
  class UpdateRecipeMutation < BaseMutation
    argument :id, ID, required: true
    argument :input, Types::RecipeInputType, required: true

    field :recipe, Types::RecipeType, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(id:, input:)
      recipe = Recipe.find(id)
      authorize(recipe, :update?)

      case UpdateRecipeForm.perform(**input, recipe: recipe)
      in Recipe => recipe
        { recipe: recipe }
      in ActiveModel::Errors => errors
        { errors: errors }
      end
    end
  end
end
