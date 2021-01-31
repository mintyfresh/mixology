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
class RecipeIngredient < ApplicationRecord
  SUPPORTED_UNITS = [
    nil,
    'gram',
    'kilogram',
    'ounce',
    'milliliter',
    'liter',
    'fluid ounce',
    'dash',
    'splash',
    'teaspoon',
    'tablespoon'
  ].freeze

  belongs_to :recipe, inverse_of: :recipe_ingredients
  belongs_to :ingredient, inverse_of: :recipe_ingredients

  validates :quantity_amount, numericality: { allow_nil: true, greater_than: 0 }
  validates :quantity_unit, inclusion: { in: SUPPORTED_UNITS }
end
