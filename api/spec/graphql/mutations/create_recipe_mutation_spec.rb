# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateRecipeMutation, type: :graphql_mutation do
  subject(:mutation) { described_class.new(object: nil, field: nil, context: context) }

  let(:context) { build(:graphql_context, current_user: current_user) }
  let(:current_user) { create(:user) }

  describe '#resolve' do
    subject(:resolve) { mutation.resolve(input: input) }

    let(:input) { build(:recipe_input) }

    it 'creates and returns a new recipe' do
      expect(resolve[:recipe]).to be_a(Recipe)
        .and be_persisted
    end

    it 'assigns the current user as the author of the recipe' do
      expect(resolve[:recipe].author).to eq(current_user)
    end

    context 'when the input is invalid' do
      let(:input) { build(:recipe_input, :invalid) }

      it 'does not return a recipe' do
        expect(resolve[:recipe]).to be_nil
      end

      it 'does not persist a recipe to the database' do
        expect { resolve }.not_to change { Recipe.count }
      end

      it 'returns a list of errors' do
        expect(resolve[:errors]).to be_present
      end
    end
  end
end
