# frozen_string_literal: true

module Mutations
  class ReportRecipeMutation < BaseMutation
    argument :recipe_id, ID, required: true
    argument :input, Types::CreateReportInputType, required: true

    field :success, Boolean, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(recipe_id:, input:)
      recipe = Recipe.find(recipe_id)
      authorize(recipe, :report?)

      case ReportRecipeForm.perform(**input.to_h, recipe: recipe, author: current_user)
      in Report
        { success: true }
      in ActiveModel::Errors => errors
        { errors: errors }
      end
    end
  end
end
