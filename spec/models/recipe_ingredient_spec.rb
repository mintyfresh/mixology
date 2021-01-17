# frozen_string_literal: true

# == Schema Information
#
# Table name: recipe_ingredients
#
#  id            :bigint           not null, primary key
#  recipe_id     :bigint           not null
#  ingredient_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
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

  it 'is invalid without a ingredient' do
    recipe_ingredient.ingredient = nil
    expect(recipe_ingredient).to be_invalid
  end
end
