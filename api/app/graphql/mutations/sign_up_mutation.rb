# frozen_string_literal: true

module Mutations
  class SignUpMutation < BaseMutation
    argument :input, Types::SignUpInputType, required: true

    field :user, Types::UserType, null: true
    field :session, Types::UserSessionType, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(input:)
      case SignUpForm.perform(input.to_h)
      in User => user
        { user: user, session: create_session!(user) }
      in ActiveModel::Errors => errors
        { errors: errors }
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
