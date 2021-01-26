# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChangePasswordForm, type: :form do
  subject(:form) { described_class.new(user: user, **input) }

  let(:input) { attributes_for(:change_password_input, old_password: old_password) }
  let!(:user) { create(:user, :with_password, password: old_password) }
  let(:old_password) { Faker::Internet.password }

  it 'has a valid input factory' do
    expect(form).to be_valid
  end

  it 'is invalid without a user' do
    input[:user] = nil
    expect(form).to be_invalid
  end

  it 'is invalid without an old password' do
    input[:old_password] = nil
    expect(form).to be_invalid
  end

  it 'is invalid when the old password is incorrect' do
    input[:old_password] = 'incorrect-password'
    expect(form).to be_invalid
  end

  it 'is invalid without a new password' do
    input[:new_password] = nil
    expect(form).to be_invalid
  end

  it 'is invalid when the new password is too short' do
    input[:new_password] = 'a' * (PasswordValidator::MINIMUM_LENGTH - 1)
    expect(form).to be_invalid
  end

  it 'is invalid when the new password is too long' do
    input[:new_password] = 'a' * (PasswordValidator::MAXIMUM_LENGTH + 1)
    expect(form).to be_invalid
  end

  it 'is invalid without a new password confirmation' do
    input[:new_password_confirmation] = nil
    expect(form).to be_invalid
  end

  it 'is invalid when the new password confirmation does not match the new password' do
    input[:new_password]              = Faker::Internet.password
    input[:new_password_confirmation] = Faker::Internet.password
    expect(form).to be_invalid
  end

  describe '.perform' do
    subject(:perform) { described_class.perform(user: user, **input) }

    it 'returns the updated user' do
      expect(perform).to eq(user)
    end

    it "changes the user's password to be the new password" do
      perform
      expect(user.authenticate(UserPasswordCredential, input[:new_password])).to be_truthy
    end

    it 'marks the password credential as having been changed' do
      freeze_time do
        expect { perform }.to change { user.credential(UserPasswordCredential).last_changed_at }.to(Time.current)
      end
    end
  end
end
