# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::UpdateRecipeMutation, type: :graphql_mutation do
  subject(:mutation) { described_class.new(object: nil, field: nil, context: context) }

  let(:context) { build(:graphql_context, current_user: current_user) }
  let(:current_user) { create(:user) }

  describe '#resolve' do
    subject(:resolve) { mutation.resolve(id: id, input: input) }

    let(:id) { recipe.id }
    let(:input) { build(:recipe_input) }
    let(:recipe) { create(:recipe, author: current_user) }

    it 'returns the updated recipe' do
      expect(resolve[:recipe]).to eq(recipe)
    end

    it 'updates the recipe with the input attributes' do
      expect(resolve[:recipe]).to have_attributes(
        name:        input.name,
        description: input.description
      )
    end

    context 'when the input is invalid' do
      let(:input) { build(:recipe_input, :invalid) }

      it 'does not return a recipe' do
        expect(resolve[:recipe]).to be_nil
      end

      it 'does not persist changes to the recipe to the database' do
        expect { resolve }.not_to change { recipe.reload.attributes }
      end

      it 'returns a list of errors' do
        expect(resolve[:errors]).to be_present
      end
    end
  end
end
