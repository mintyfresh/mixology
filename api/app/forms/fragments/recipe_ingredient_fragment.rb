# frozen_string_literal: true

module Fragments
  class RecipeIngredientFragment < ApplicationFragment
    attribute :name, Types::StrippedString
    attribute :quantity_amount, Types::Integer | Types::Float
    attribute :quantity_unit, Types::String
    attribute :optional, Types::Boolean, default: false

    validates :name, presence: true, length: { maximum: Ingredient::NAME_MAX_LENGTH }
    validates :quantity_amount, numericality: { allow_nil: true, greater_than: 0 }
    validates :quantity_unit, inclusion: { in: RecipeIngredient::SUPPORTED_UNITS }

    # @return [RecipeIngredient]
    def build_recipe_ingredient
      RecipeIngredient.new(
        ingredient:      Ingredient.create_or_find_by!(name: name),
        quantity_amount: quantity_amount,
        quantity_unit:   quantity_unit,
        optional:        optional
      )
    end
  end
end
