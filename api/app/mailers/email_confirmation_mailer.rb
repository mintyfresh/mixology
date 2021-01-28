# frozen_string_literal: true

class EmailConfirmationMailer < ApplicationMailer
  def email_confirmation
    @email_confirmation = params[:email_confirmation]

    mail to: @email_confirmation.email
  end
end
