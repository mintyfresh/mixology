# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples_for BaseRecipeForm, type: :form do
  it 'inherits BaseRecipeForm' do
    expect(form.class).to be < BaseRecipeForm
  end

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
end
