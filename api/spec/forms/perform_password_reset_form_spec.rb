# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PerformPasswordResetForm, type: :form do
  subject(:form) { described_class.new(**input, password_reset: password_reset) }

  let!(:password_reset) { create(:password_reset) }
  let(:input) { attributes_for(:perform_password_reset_input) }

  it 'has a valid input factory' do
    expect(form).to be_valid
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

  it 'is invalid when the password reset is expired' do
    password_reset.expires_at = 5.minutes.ago
    expect(form).to be_invalid
  end

  it 'is invalid when the new password confirmation does not match the new password' do
    input[:new_password]              = Faker::Internet.password
    input[:new_password_confirmation] = Faker::Internet.password
    expect(form).to be_invalid
  end

  describe '.perform' do
    subject(:perform) { described_class.perform(**input, password_reset: password_reset) }

    let(:user) { password_reset.user }

    it 'returns the completed password reset' do
      expect(perform).to eq(password_reset)
        .and be_completed
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

    context 'when the password reset has already been completed' do
      let(:password_reset) { create(:password_reset, :completed) }

      it 'returns a list of errors' do
        expect(perform).to be_a(ActiveModel::Errors)
          .and be_of_kind(:base, :completed)
      end

      it 'does not perform a password change' do
        perform
        expect(user.authenticate(UserPasswordCredential, input[:new_password])).to be_falsey
      end
    end
  end
end
