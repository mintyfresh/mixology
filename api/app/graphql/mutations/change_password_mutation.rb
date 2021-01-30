# frozen_string_literal: true

module Mutations
  class ChangePasswordMutation < BaseMutation
    argument :input, Types::ChangePasswordInputType, required: true

    field :success, Boolean, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(input:)
      authorize(current_user, :change_password?)

      case ChangePasswordForm.perform(user: current_user, **input.to_h)
      in User
        { success: true }
      in ActiveModel::Errors => errors
        { errors: errors }
      end
    end
  end
end
