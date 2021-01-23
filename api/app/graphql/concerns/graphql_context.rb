# frozen_string_literal: true

module GraphQLContext
  # @return [User, nil]
  def current_user
    current_session&.user
  end

  # @return [UserSession, nil]
  def current_session
    context[:current_session]
  end

  # @return [String]
  def ip
    context[:ip]
  end

  # @return [String, nil]
  def user_agent
    context[:user_agent]
  end
end
