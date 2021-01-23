# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SignInForm, type: :form do
  subject(:form) { described_class.new(input) }

  let(:input) { attributes_for(:sign_in_input) }

  it 'has a valid input factory' do
    expect(form).to be_valid
  end

  it 'is invalid without an email' do
    input[:email] = nil
    expect(form).to be_invalid
  end

  it 'is invalid when the emails is invalid' do
    input[:email] = 'fake-email'
    expect(form).to be_invalid
  end

  it 'is invalid without a password' do
    input[:password] = nil
    expect(form).to be_invalid
  end

  describe '.perform' do
    subject(:perform) { described_class.perform(input) }

    let(:user) { User.find_by(email: input[:email]) }

    it 'returns the authenticated user' do
      expect(perform).to eq(user)
    end

    context 'when the email does not exist' do
      let(:input) { attributes_for(:sign_in_input, :incorrect_email) }

      it 'returns an incorrect credential error' do
        expect(perform).to be_of_kind(:base, :incorrect_credentials)
      end
    end

    context 'when the password is incorrect' do
      let(:input) { attributes_for(:sign_in_input, :incorrect_password) }

      it 'returns an incorrect credential error' do
        expect(perform).to be_of_kind(:base, :incorrect_credentials)
      end
    end
  end
end
