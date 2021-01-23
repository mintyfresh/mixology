# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::SignInMutation, type: :graphql_mutation do
  subject(:mutation) { described_class.new(object: nil, field: nil, context: context) }

  let(:context) { { current_user: nil } }

  describe '#resolve' do
    subject(:resolve) { mutation.resolve(input: input) }

    let(:input) { build(:sign_in_input) }
    let(:user) { User.find_by(email: input.email) }

    it 'returns the authenticated user' do
      expect(resolve[:user]).to eq(user)
    end

    it 'returns a session for the authenticated user' do
      expect(resolve[:session]).to be_a(UserSession)
        .and be_persisted
        .and have_attributes(user: user)
    end

    context 'when the input is invalid' do
      let(:input) { build(:sign_in_input, :invalid) }

      it 'does not return a user' do
        expect(resolve[:user]).to be_nil
      end

      it 'does not return a session' do
        expect(resolve[:session]).to be_nil
      end

      it 'does not persist a user session to the database' do
        expect { resolve }.not_to change { UserSession.count }
      end

      it 'returns a list of errors' do
        expect(resolve[:errors]).to be_present
      end
    end
  end
end
