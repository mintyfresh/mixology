# frozen_string_literal: true

module Mutations
  class CreateReviewMutation < BaseMutation
    argument :recipe_id, ID, required: true
    argument :input, Types::CreateReviewInputType, required: true

    field :recipe, Types::RecipeType, null: true
    field :review, Types::ReviewType, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(recipe_id:, input:)
      recipe = Recipe.find(recipe_id)
      authorize(recipe, :review?)

      input = input.to_h.merge(author: current_user)

      case (result = CreateReviewForm.perform(input))
      when Review
        { recipe: result.recipe, review: result }
      when ActiveModel::Errors
        { errors: result }
      end
    end
  end
end
