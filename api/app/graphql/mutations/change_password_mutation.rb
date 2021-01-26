# frozen_string_literal: true

module Mutations
  class ChangePasswordMutation < BaseMutation
    argument :input, Types::ChangePasswordInputType, required: true

    field :success, Boolean, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(input:)
      authorize(current_user, :change_password?)

      case (result = ChangePasswordForm.perform(user: current_user, **input.to_h))
      when User
        { success: true }
      when ActiveModel::Errors
        { errors: result }
      end
    end
  end
end
