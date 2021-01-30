# frozen_string_literal: true

module Mutations
  class CreateRecipeMutation < BaseMutation
    argument :input, Types::CreateRecipeInputType, required: true

    field :recipe, Types::RecipeType, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(input:)
      authorize(Recipe, :create?)

      case CreateRecipeForm.perform(**input.to_h, author: current_user)
      in Recipe => recipe
        { recipe: recipe }
      in ActiveModel::Errors => errors
        { errors: errors }
      end
    end
  end
end
