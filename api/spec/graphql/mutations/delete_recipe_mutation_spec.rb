# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::DeleteRecipeMutation, type: :graphql_mutation do
  subject(:mutation) { described_class.new(object: nil, field: nil, context: context) }

  let(:context) { { current_user: current_user } }
  let(:current_user) { create(:user) }

  describe '#resolve' do
    subject(:resolve) { mutation.resolve(id: id) }

    let(:id) { recipe.id }
    let!(:recipe) { create(:recipe, author: current_user) }

    it 'returns success' do
      expect(resolve[:success]).to be(true)
    end

    it 'marks the recipe as deleted' do
      expect { resolve }.to change { Recipe.count }.by(-1)
    end

    context 'when the specified recipe does not exist' do
      let(:id) { -1 }

      it 'raises an ActiveRecord::RecordNotFound error' do
        expect { resolve }.to raise_error(ActiveRecord::RecordNotFound)
          .and not_change { Recipe.count }
      end
    end

    context 'when the user is not allowed to delete the recipe' do
      let(:recipe) { create(:recipe) }

      it 'raises a Pundit::NotAuthorizedError' do
        expect { resolve }.to raise_error(Pundit::NotAuthorizedError)
          .and not_change { Recipe.count }
      end
    end
  end
end
