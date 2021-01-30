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

      case CreateReviewForm.perform(**input.to_h, author: current_user)
      in Review => review
        { recipe: review.recipe, review: review }
      in ActiveModel::Errors => errors
        { errors: errors }
      end
    end
  end
end
