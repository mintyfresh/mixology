# frozen_string_literal: true

require 'rails_helper'
require_relative './base_recipe_form'

RSpec.describe UpdateRecipeForm, type: :form do
  subject(:form) { described_class.new(**input, recipe: recipe) }

  let(:input) { attributes_for(:recipe_input) }
  let(:recipe) { create(:recipe) }

  it_behaves_like BaseRecipeForm

  describe '.perform' do
    subject(:perform) { described_class.perform(**input, recipe: recipe) }

    it 'returns the updated recipe' do
      expect(perform).to eq(recipe)
    end

    it 'updates the name and description of the recipe' do
      expect(perform).to have_attributes(
        name:        input[:name],
        description: input[:description]
      )
    end

    context 'with ingredients' do
      let(:input) { attributes_for(:recipe_input, :with_ingredients) }

      it 'associates the ingredients to the recipe' do
        expect(perform.ingredients.map(&:name)).to contain_exactly(*input[:ingredients].pluck(:name))
      end

      it 'references existing ingredients when they already exist' do
        ingredients = input[:ingredients].map { |ingredient| create(:ingredient, name: ingredient[:name]) }
        expect(perform.ingredients).to contain_exactly(*ingredients)
      end
    end

    context 'with equipments' do
      let(:input) { attributes_for(:recipe_input, :with_equipment) }

      it 'associates the equipments to the recipe' do
        expect(perform.equipments.map(&:name)).to contain_exactly(*input[:equipments].pluck(:name))
      end

      it 'references existing equipments when they already exist' do
        equipments = input[:equipments].map { |equipment| create(:equipment, name: equipment[:name]) }
        expect(perform.equipments).to contain_exactly(*equipments)
      end
    end

    context 'with steps' do
      let(:input) { attributes_for(:recipe_input, :with_steps) }

      it 'adds the steps to the recipe' do
        expect(perform.steps.map(&:body)).to contain_exactly(*input[:steps])
      end
    end

    context 'when the input is invalid' do
      let(:input) { attributes_for(:recipe_input, :invalid) }

      it 'returns a list of errors' do
        expect(perform).to be_a(ActiveModel::Errors)
          .and be_of_kind(:name, :blank)
      end

      it "doesn't persist changes to the database" do
        expect { perform }.not_to change { recipe.reload.attributes }
      end

      it "doesn't persist any associated ingredients to the database" do
        input[:ingredients] = build_list(:recipe_ingredient_input, 3)
        expect { perform }.not_to change { Ingredient.count }
      end

      it "doesn't persist any associated equipments to the database" do
        input[:equipments] = build_list(:recipe_equipment_input, 3)
        expect { perform }.not_to change { Equipment.count }
      end
    end
  end
end
