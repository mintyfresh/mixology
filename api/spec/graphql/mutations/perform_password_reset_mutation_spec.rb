# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::PerformPasswordResetMutation, type: :graphql_mutation do
  subject(:mutation) { described_class.new(object: nil, field: nil, context: context) }

  let(:context) { build(:graphql_context, :guest) }

  describe '#resolve' do
    subject(:resolve) { mutation.resolve(token: token, input: input) }

    let(:token) { password_reset.token }
    let(:input) { build(:perform_password_reset_input) }
    let(:user) { password_reset.user }
    let(:password_reset) { create(:password_reset) }

    it 'returns success' do
      expect(resolve[:success]).to be(true)
    end

    it "changes the user's password" do
      expect { resolve }.to change { user.credential(UserPasswordCredential).password_digest }
    end

    it 'allows the user to log in with the new password' do
      resolve
      expect(user.authenticate(UserPasswordCredential, input.new_password)).to be_truthy
    end

    context 'when the token is invalid' do
      let(:token) { 'fake-token' }

      it 'returns a list of errors' do
        expect(resolve[:errors]).to be_present
      end

      it 'does not perform a password change' do
        expect { resolve }.not_to change { user.credential(UserPasswordCredential).password_digest }
      end
    end

    context 'when the password reset has already been completed' do
      let(:password_reset) { create(:password_reset, :completed) }

      it 'returns a list of errors' do
        expect(resolve[:errors]).to be_present
      end

      it 'does not perform a password change' do
        expect { resolve }.not_to change { user.credential(UserPasswordCredential).password_digest }
      end
    end

    context 'when the password reset is expired' do
      let(:password_reset) { create(:password_reset, :expired) }

      it 'returns a list of errors' do
        expect(resolve[:errors]).to be_present
      end

      it 'does not perform a password change' do
        expect { resolve }.not_to change { user.credential(UserPasswordCredential).password_digest }
      end
    end
  end
end
