# frozen_string_literal: true

class PasswordResetMailer < ApplicationMailer
  def request_password_reset
    @password_reset = params[:password_reset]

    mail to: @password_reset.email
  end
end
