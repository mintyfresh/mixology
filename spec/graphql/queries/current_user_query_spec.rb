# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::CurrentUserQuery, type: :graphql_query do
  subject(:query) { described_class.new(object: nil, field: nil, context: context) }

  let(:context) { { current_user: current_user } }
  let(:current_user) { create(:user) }

  describe '#resolve' do
    subject(:resolve) { query.resolve }

    it 'returns the current user' do
      expect(resolve).to eq(current_user)
    end

    context 'when the current user is not logged in' do
      let(:current_user) { nil }

      it 'returns nil' do
        expect(resolve).to be_nil
      end
    end
  end
end
