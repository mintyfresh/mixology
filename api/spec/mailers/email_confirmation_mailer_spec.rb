# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmailConfirmationMailer, type: :mailer do
  subject(:mailer) { described_class }

  describe '.email_confirmation' do
    subject(:mail) { mailer.with(email_confirmation: email_confirmation).email_confirmation }

    let(:email_confirmation) { create(:email_confirmation) }

    it 'sends the email to the unconfirmed email' do
      expect(mail.to).to contain_exactly(email_confirmation.email)
    end

    it 'includes a confirmation link in the email' do
      expect(mail.body).to include(email_confirmation.web_link)
    end
  end
end
