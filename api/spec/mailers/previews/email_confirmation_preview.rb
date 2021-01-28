# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/email_confirmation
class EmailConfirmationPreview < ActionMailer::Preview
  def email_confirmation
    email_confirmation = FactoryBot.create(:email_confirmation)

    EmailConfirmationMailer.with(email_confirmation: email_confirmation).email_confirmation
  end
end
