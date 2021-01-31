# frozen_string_literal: true

class PerformPasswordResetForm < ApplicationForm
  attribute :password_reset, Types::Instance(PasswordReset)
  attribute :new_password, Types::String
  attribute :new_password_confirmation, Types::String

  validates :password_reset, presence: true
  validate  :password_reset_is_not_expired, if: -> { password_reset }
  validates :new_password, password: true, confirmation: true
  validates :new_password_confirmation, presence: true

  # @return [PasswordReset]
  def perform
    password_reset.with_lock do
      errors.add(:base, :completed) && throw(:abort) if password_reset.completed?

      password_reset.completed!
      password_reset.user.credential(UserPasswordCredential, build_if_missing: true).update!(password: new_password)
    end

    password_reset
  end

private

  # @return [void]
  def password_reset_is_not_expired
    errors.add(:base, :expired) && throw(:abort) if password_reset.expired?
  end
end
