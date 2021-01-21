# frozen_string_literal: true

module Mutations
  class DeleteRecipeMutation < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(id:)
      recipe = Recipe.find(id)
      authorize(recipe, :destroy?)

      if recipe.destroy
        { success: true }
      else
        { errors: recipe.errors }
      end
    end
  end
end
