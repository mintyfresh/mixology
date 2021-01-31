# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RequestPasswordResetForm, type: :form do
  subject(:form) { described_class.new(input) }

  let(:input) { { email: email } }
  let(:email) { user.email }
  let(:user) { create(:user) }

  it 'has a valid input factory' do
    expect(form).to be_valid
  end

  it 'is invalid without an email' do
    input[:email] = nil
    expect(form).to be_invalid
  end

  it 'is invalid when the email is malformed' do
    input[:email] = 'invalid-email'
    expect(form).to be_invalid
  end

  it 'is valid when the email does not have a matching user' do
    input[:email] = Faker::Internet.email
    expect(form).to be_valid
  end

  describe '.perform' do
    subject(:perform) { described_class.perform(input) }

    it 'creates and returns a new password reset' do
      expect(perform).to be_a(PasswordReset)
        .and be_persisted
        .and have_attributes(email: email)
    end

    it 'associates the password reset to the user with the matching email' do
      expect(perform.user).to eq(user)
    end

    context 'when the email does not have a matching user' do
      let(:email) { Faker::Internet.email }

      it 'creates and returns a password reset without a user' do
        expect(perform).to be_a(PasswordReset)
          .and be_persisted
          .and have_attributes(user: nil)
      end
    end
  end
end
