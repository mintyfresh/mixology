# frozen_string_literal: true

class ApplicationController < ActionController::API
  SESSION_AUTHORIZATION = 'Session'

  # @return [User, nil]
  def current_user
    current_session&.user
  end

  # @return [UserSession, nil]
  def current_session
    return @current_session if defined?(@current_session)

    @current_session = UserSession.find_by_token(user_session_token)
  end

private

  # @return [String, nil]
  def user_session_token
    authorization = request.headers['Authorization']
    return if authorization.blank?

    type, token = authorization.split(' ', 2)
    return if type != SESSION_AUTHORIZATION || token.blank?

    token
  end
end
