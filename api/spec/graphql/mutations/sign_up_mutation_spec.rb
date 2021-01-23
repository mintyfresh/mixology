# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::SignUpMutation, type: :graphql_mutation do
  subject(:mutation) { described_class.new(object: nil, field: nil, context: context) }

  let(:context) { build(:graphql_context, :guest) }

  describe '#resolve' do
    subject(:resolve) { mutation.resolve(input: input) }

    let(:input) { build(:sign_up_input) }

    it 'returns a new user' do
      expect(resolve[:user]).to be_a(User)
        .and be_persisted
    end

    it 'assigns attributes from the input to the new user' do
      expect(resolve[:user]).to have_attributes(
        email:         input.email,
        display_name:  input.display_name,
        date_of_birth: input.date_of_birth
      )
    end

    it 'returns a session for the new user' do
      expect(resolve[:session]).to be_a(UserSession)
        .and be_persisted
        .and have_attributes(user: resolve[:user])
    end

    context 'when the input is invalid' do
      let(:input) { build(:sign_up_input, :invalid) }

      it 'does not return a user' do
        expect(resolve[:user]).to be_nil
      end

      it 'does not return a session' do
        expect(resolve[:session]).to be_nil
      end

      it 'does not persist a user to the database' do
        expect { resolve }.not_to change { User.count }
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
