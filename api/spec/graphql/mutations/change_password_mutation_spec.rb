# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::ChangePasswordMutation, type: :graphql_mutation do
  subject(:mutation) { described_class.new(object: nil, field: nil, context: context) }

  let(:context) { build(:graphql_context, current_user: current_user) }
  let(:current_user) { create(:user, :with_password, password: old_password) }
  let(:old_password) { Faker::Internet.password }

  describe '#resolve' do
    subject(:resolve) { mutation.resolve(input: input) }

    let(:input) { build(:change_password_input, old_password: old_password) }

    it 'returns success' do
      expect(resolve[:success]).to be(true)
    end

    it "changes the current user's password" do
      expect { resolve }.to change { current_user.credential(UserPasswordCredential).password_digest }
    end

    it 'allows the current user to log in with the new password' do
      resolve
      expect(current_user.authenticate(UserPasswordCredential, input.new_password)).to be_truthy
    end

    context 'when the input is invalid' do
      let(:input) { build(:change_password_input, :invalid) }

      it 'returns a list of errors' do
        expect(resolve[:errors]).to be_present
      end

      it "does not change the current user's password" do
        expect { resolve }.not_to change { current_user.credential(UserPasswordCredential).password_digest }
      end
    end

    context 'when there is no current user' do
      let(:current_user) { nil }

      it 'raises a Pundit::NotAuthorizedError' do
        expect { resolve }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end
