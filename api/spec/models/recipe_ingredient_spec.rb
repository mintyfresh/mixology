# frozen_string_literal: true

# == Schema Information
#
# Table name: recipe_ingredients
#
#  id              :bigint           not null, primary key
#  recipe_id       :bigint           not null
#  ingredient_id   :bigint           not null
#  quantity_amount :float
#  quantity_unit   :string
#  optional        :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_recipe_ingredients_on_ingredient_id                (ingredient_id)
#  index_recipe_ingredients_on_recipe_id                    (recipe_id)
#  index_recipe_ingredients_on_recipe_id_and_ingredient_id  (recipe_id,ingredient_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (ingredient_id => ingredients.id)
#  fk_rails_...  (recipe_id => recipes.id)
#
require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  subject(:recipe_ingredient) { build(:recipe_ingredient) }

  it 'has a valid factory' do
    expect(recipe_ingredient).to be_valid
  end

  it 'is invalid without a recipe' do
    recipe_ingredient.recipe = nil
    expect(recipe_ingredient).to be_invalid
  end

  it 'is invalid without an ingredient' do
    recipe_ingredient.ingredient = nil
    expect(recipe_ingredient).to be_invalid
  end

  it 'is valid without a quantity amount' do
    recipe_ingredient.quantity_amount = nil
    expect(recipe_ingredient).to be_valid
  end

  it 'is invalid when quantity amount is zero' do
    recipe_ingredient.quantity_amount = 0
    expect(recipe_ingredient).to be_invalid
  end

  it 'is invalid when quantity amount is negative' do
    recipe_ingredient.quantity_amount = -1
    expect(recipe_ingredient).to be_invalid
  end

  it 'is valid without a quantity unit' do
    recipe_ingredient.quantity_unit = nil
    expect(recipe_ingredient).to be_valid
  end

  it 'is invalid when the quantity unit is unsupported' do
    recipe_ingredient.quantity_unit = 'unsupported'
    expect(recipe_ingredient).to be_invalid
  end
end
