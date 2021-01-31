# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordResetMailer, type: :mailer do
  subject(:mailer) { described_class }

  describe '.request_password_reset' do
    subject(:mail) { mailer.with(password_reset: password_reset).request_password_reset }

    let(:password_reset) { create(:password_reset) }

    it 'sends the email to the unconfirmed email' do
      expect(mail.to).to contain_exactly(password_reset.email)
    end

    it 'includes a confirmation link in the email' do
      expect(mail.body).to include(password_reset.web_link)
    end
  end
end
