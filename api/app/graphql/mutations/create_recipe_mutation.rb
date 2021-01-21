# frozen_string_literal: true

module Mutations
  class CreateRecipeMutation < BaseMutation
    argument :input, Types::CreateRecipeInputType, required: true

    field :recipe, Types::RecipeType, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(input:)
      authorize(Recipe, :create?)
      input = input.to_h.merge(author: current_user)

      case (result = CreateRecipeForm.perform(input))
      when Recipe
        { recipe: result }
      else
        { errors: result }
      end
    end
  end
end
