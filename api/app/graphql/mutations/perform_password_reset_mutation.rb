# frozen_string_literal: true

module Mutations
  class PerformPasswordResetMutation < BaseMutation
    argument :token, String, required: true
    argument :input, Types::PerformPasswordResetInputType, required: true

    field :success, Boolean, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(token:, input:)
      password_reset = PasswordReset.find_by_token(token)

      case PerformPasswordResetForm.perform(**input.to_h, password_reset: password_reset)
      in PasswordReset
        { success: true }
      in ActiveModel::Errors => errors
        { errors: errors }
      end
    end
  end
end
