# frozen_string_literal: true

module Types
  class ChangePasswordInputType < BaseInputObject
    argument :old_password, String, required: true
    argument :new_password, String, required: true
    argument :new_password_confirmation, String, required: true
  end
end
