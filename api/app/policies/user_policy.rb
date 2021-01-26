# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  alias user record

  def change_password?
    current_user.present? && current_user == user
  end
end
