# frozen_string_literal: true

module Mutations
  class RequestPasswordResetMutation < BaseMutation
    argument :email, String, required: true

    field :success, Boolean, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(email:)
      authorize(PasswordReset, :request?)

      case RequestPasswordResetForm.perform(email: email)
      in PasswordReset
        { success: true }
      in ActiveModel::Errors => errors
        { errors: errors }
      end
    end
  end
end
