# frozen_string_literal: true

module Types
  class PerformPasswordResetInputType < BaseInputObject
    argument :new_password, String, required: true
    argument :new_password_confirmation, String, required: true
  end
end
