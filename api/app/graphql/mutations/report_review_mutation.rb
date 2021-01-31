# frozen_string_literal: true

module Mutations
  class ReportReviewMutation < BaseMutation
    argument :review_id, ID, required: true
    argument :input, Types::CreateReportInputType, required: true

    field :success, Boolean, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(review_id:, input:)
      review = Review.find(review_id)
      authorize(review, :report?)

      case ReportReviewForm.perform(**input.to_h, review: review, author: current_user)
      in Report
        { success: true }
      in ActiveModel::Errors => errors
        { errors: errors }
      end
    end
  end
end
