# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/password_reset_mailer
class PasswordResetMailerPreview < ActionMailer::Preview
  def request_password_reset
    password_reset = FactoryBot.create(:password_reset)

    PasswordResetMailer.with(password_reset: password_reset).request_password_reset
  end
end
