# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::SignOutMutation, type: :graphql_mutation do
  subject(:mutation) { described_class.new(object: nil, field: nil, context: context) }

  let(:context) { build(:graphql_context) }
  let(:current_session) { context[:current_session] }

  describe '#resolve' do
    subject(:resolve) { mutation.resolve }

    it 'returns success' do
      expect(resolve[:success]).to be_truthy
    end

    it 'revokes the current session' do
      expect { resolve }.to change { current_session.revoked? }.to(true)
    end

    context 'when the user is not logged in' do
      let(:context) { build(:graphql_context, :guest) }

      it 'returns success' do
        expect(resolve[:success]).to be_truthy
      end
    end
  end
end
