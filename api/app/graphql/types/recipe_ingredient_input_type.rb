# frozen_string_literal: true

module Types
  class RecipeIngredientInputType < BaseInputObject
    argument :name, String, required: true
    argument :quantity_amount, Float, required: false
    argument :quantity_unit, String, required: false
    argument :optional, Boolean, required: true
  end
end
