# frozen_string_literal: true

module GraphQLContext
  # @return [User, nil]
  def current_user
    context[:current_user]
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
