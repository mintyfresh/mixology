# frozen_string_literal: true

class RequestPasswordResetForm < ApplicationForm
  attribute :email, Types::StrippedString

  validates :email, email: true

  # @return [PasswordReset]
  def perform
    password_reset = PasswordReset.create!(email: email)

    # Only send a password reset email if a user actually exists for the requested email address.
    send_password_reset_email(password_reset) if password_reset.user.present?

    password_reset
  end

private

  # @param password_reset [PasswordReset]
  # @return [void]
  def send_password_reset_email(password_reset)
    PasswordResetMailer.with(password_reset: password_reset).request_password_reset.deliver_later
  end
end
