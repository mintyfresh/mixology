# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::RecipeQuery, type: :graphql_query do
  subject(:query) { described_class.new(object: nil, field: nil, context: context) }

  let(:context) { build(:graphql_context, current_user: current_user) }
  let(:current_user) { create(:user) }

  describe '#resolve' do
    subject(:resolve) { query.resolve(id: id) }

    let(:id) { recipe.id }
    let(:recipe) { create(:recipe) }

    it 'returns the requested recipe' do
      expect(resolve).to eq(recipe)
    end

    context 'when the requested recipe does not exist' do
      let(:id) { -1 }

      it 'raises an ActiveRecord::RecordNotFound error' do
        expect { resolve }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
