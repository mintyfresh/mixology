# frozen_string_literal: true

module Mutations
  class ConfirmEmailMutation < BaseMutation
    argument :token, String, required: true do
      description 'The unique email confirmation token delivered to the unconfirmed email.'
    end

    field :success, Boolean, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(token:)
      email_confirmation = EmailConfirmation.find_by_token(token)

      case ConfirmEmailForm.perform(email_confirmation: email_confirmation)
      in EmailConfirmation
        { success: true }
      in ActiveModel::Errors => errors
        { errors: errors }
      end
    end
  end
end
