# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SignUpForm, type: :form do
  subject(:form) { described_class.new(input) }

  let(:input) { attributes_for(:sign_up_input) }

  it 'has a valid input factory' do
    expect(form).to be_valid
  end

  it 'is invalid without an email' do
    input[:email] = nil
    expect(form).to be_invalid
  end

  it 'is invalid when the email is malformed' do
    input[:email] = 'fake-invalid'
    expect(form).to be_invalid
  end

  it 'is invalid without a display name' do
    input[:display_name] = nil
    expect(form).to be_invalid
  end

  it 'is invalid when the display name contains unsupported characters' do
    input[:display_name] = "\0"
    expect(form).to be_invalid
  end

  it 'is invalid without a password' do
    input[:password] = nil
    expect(form).to be_invalid
  end

  it 'is invalid when the password is too short' do
    input[:password] = 'a' * (PasswordValidator::MINIMUM_LENGTH - 1)
    expect(form).to be_invalid
  end

  it 'is invalid when the password is too long' do
    input[:password] = 'a' * (PasswordValidator::MAXIMUM_LENGTH + 1)
    expect(form).to be_invalid
  end

  it 'is invalid without a password confirmation' do
    input[:password_confirmation] = nil
    expect(form).to be_invalid
  end

  it "is invalid when the password confirmation doesn't match the password" do
    input[:password_confirmation] = 'different'
    expect(form).to be_invalid
  end

  it 'is invalid without a date of birth' do
    input[:date_of_birth] = nil
    expect(form).to be_invalid
  end

  describe '.perform' do
    subject(:perform) { described_class.perform(input) }

    it 'returns a new user record' do
      expect(perform).to be_a(User)
        .and be_persisted
    end

    it 'assigns the input attributes to the user' do
      expect(perform).to have_attributes(
        email:         input[:email],
        display_name:  input[:display_name],
        date_of_birth: input[:date_of_birth]
      )
    end

    it "sets the user's password from the input" do
      expect(perform.authenticate(UserPasswordCredential, input[:password])).to be_truthy
    end

    context 'when the input is invalid' do
      let(:input) { build(:sign_up_input, :invalid) }

      it 'returns a list of errors' do
        expect(perform).to be_a(ActiveModel::Errors)
          .and be_of_kind(:email, :email)
      end

      it 'does not persist the user to the database' do
        expect { perform }.not_to change { User.count }
      end
    end
  end
end
