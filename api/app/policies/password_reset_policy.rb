# frozen_string_literal: true

class PasswordResetPolicy < ApplicationPolicy
  def request?
    current_user.nil?
  end
end
