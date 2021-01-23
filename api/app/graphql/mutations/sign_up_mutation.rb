# frozen_string_literal: true

module Mutations
  class SignUpMutation < BaseMutation
    argument :input, Types::SignUpInputType, required: true

    field :user, Types::UserType, null: true
    field :session, Types::UserSessionType, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(input:)
      case (result = SignUpForm.perform(input.to_h))
      when User
        { user: result, session: create_session!(result) }
      when ActiveModel::Errors
        { errors: result }
      end
    end

  private

    # @param user [User]
    # @return [UserSession]
    def create_session!(user)
      user.sessions.create!(
        creation_ip:         ip,
        creation_user_agent: user_agent
      )
    end
  end
end
