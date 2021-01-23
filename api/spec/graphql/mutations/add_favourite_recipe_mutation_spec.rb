# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AddFavouriteRecipeMutation, type: :graphql_mutation do
  subject(:mutation) { described_class.new(object: nil, field: nil, context: context) }

  let(:context) { build(:graphql_context, current_user: current_user) }
  let(:current_user) { create(:user) }

  describe '#resolve' do
    subject(:resolve) { mutation.resolve(id: id) }

    let(:id) { recipe.id }
    let(:recipe) { create(:recipe) }

    it 'returns the specified recipe' do
      expect(resolve[:recipe]).to eq(recipe)
    end

    it "adds the recipe to the current user's favourites" do
      resolve
      expect(recipe).to be_favourited_by(current_user)
    end

    context 'when the specified recipe does not exist' do
      let(:id) { -1 }

      it 'raises an ActiveRecord::RecordNotFound error' do
        expect { resolve }.to raise_error(ActiveRecord::RecordNotFound)
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
