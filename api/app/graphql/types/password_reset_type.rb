# frozen_string_literal: true

module Types
  class PasswordResetType < BaseObject
    field :email, String, null: false
    field :expired, Boolean, null: false, method: :expired?
  end
end
