# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::RecipesQuery, type: :graphql_query do
  subject(:query) { described_class.new(object: nil, field: nil, context: context) }

  let(:context) { { current_user: current_user } }
  let(:current_user) { create(:user) }

  describe '#resolve' do
    subject(:resolve) { query.resolve }

    let!(:recipes) { create_list(:recipe, 3) }

    it 'returns a list of recipes' do
      expect(resolve).to eq(recipes.sort_by(&:id))
    end
  end
end
