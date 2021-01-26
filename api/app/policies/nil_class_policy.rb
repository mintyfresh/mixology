# frozen_string_literal: true

class NilClassPolicy < ApplicationPolicy
  def change_password?
    # Trying to change password without authentication.
    false
  end
end
