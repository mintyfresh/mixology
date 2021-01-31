# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateRecipeForm, type: :form do
  subject(:form) { described_class.new(**input, author: author) }

  let(:input) { attributes_for(:recipe_input) }
  let(:author) { create(:user) }

  it 'has a valid input factory' do
    expect(form).to be_valid
  end

  it 'is invalid without a name' do
    input[:name] = nil
    expect(form).to be_invalid
  end

  it 'is invalid when the name is too long' do
    input[:name] = 'a' * (Recipe::NAME_MAX_LENGTH + 1)
    expect(form).to be_invalid
  end

  it 'is valid without a description' do
    input[:description] = nil
    expect(form).to be_valid
  end

  it 'is invalid when the description is too long' do
    input[:description] = 'a' * (Recipe::DESCRIPTION_MAX_LENGTH + 1)
    expect(form).to be_invalid
  end

  context 'with ingredients' do
    let(:input) { attributes_for(:recipe_input, :with_ingredients) }

    it 'has a valid input factory' do
      expect(form).to be_valid
    end

    it 'is invalid with too many ingredients' do
      input[:ingredients] = build_list(:recipe_ingredient_input, Recipe::INGREDIENTS_MAX_LENGTH + 1)
      expect(form).to be_invalid
    end

    it 'is invalid when an ingredient has no name' do
      input[:ingredients][0][:name] = nil
      expect(form).to be_invalid
    end

    it 'is invalid when an ingredient name is too long' do
      input[:ingredients][0][:name] = 'a' * (Ingredient::NAME_MAX_LENGTH + 1)
      expect(form).to be_invalid
    end

    it 'is valid when an ingredient quantity amount is blank' do
      input[:ingredients][0][:quantity_amount] = nil
      expect(form).to be_valid
    end

    it 'is invalid when an ingredient quantity amount is zero' do
      input[:ingredients][0][:quantity_amount] = 0
      expect(form).to be_invalid
    end

    it 'is invalid when an ingredient quantity amount is negative' do
      input[:ingredients][0][:quantity_amount] = -1
      expect(form).to be_invalid
    end

    it 'is valid when an ingredient quantity unit is blank' do
      input[:ingredients][0][:quantity_unit] = nil
      expect(form).to be_valid
    end

    it 'is invalid when an ingredient quantity unit is unsupported' do
      input[:ingredients][0][:quantity_unit] = 'unsupported'
      expect(form).to be_invalid
    end
  end

  context 'with equipment' do
    let(:input) { attributes_for(:recipe_input, :with_equipment) }

    it 'has a valid input factory' do
      expect(form).to be_valid
    end

    it 'is invalid with too many equipment' do
      input[:equipments] = build_list(:recipe_equipment_input, Recipe::EQUIPMENTS_MAX_LENGTH + 1)
      expect(form).to be_invalid
    end

    it 'is invalid when an equipment has no name' do
      input[:equipments][0][:name] = nil
      expect(form).to be_invalid
    end

    it 'is invalid when an equipment name is too long' do
      input[:equipments][0][:name] = 'a' * (Equipment::NAME_MAX_LENGTH + 1)
      expect(form).to be_invalid
    end

    it 'is valid when an equipment quantity is blank' do
      input[:equipments][0][:quantity] = nil
      expect(form).to be_valid
    end

    it 'is invalid when an equipment quantity is zero' do
      input[:equipments][0][:quantity] = 0
      expect(form).to be_invalid
    end

    it 'is invalid when an equipment quantity is negative' do
      input[:equipments][0][:quantity] = -1
      expect(form).to be_invalid
    end
  end

  context 'with steps' do
    let(:input) { attributes_for(:recipe_input, :with_steps) }

    it 'has a valid input factory' do
      expect(form).to be_valid
    end

    it 'is invalid with too many steps' do
      input[:steps] = Array.new(Recipe::STEPS_MAX_LENGTH + 1) { 'step' }
      expect(form).to be_invalid
    end
  end

  describe '#perform' do
    subject(:perform) { described_class.perform(**input, author: author) }

    it 'creates a recipe owned by the author' do
      expect(perform).to be_a(Recipe)
        .and be_persisted
        .and have_attributes(author: author)
    end

    it 'assigns the input attributes to the recipe' do
      expect(perform).to have_attributes(input)
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

      it "doesn't persist a recipe to the database" do
        expect { perform }.not_to change { Recipe.count }
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
