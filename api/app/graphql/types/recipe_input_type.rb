# frozen_string_literal: true

module Types
  class RecipeInputType < BaseInputObject
    argument :name, String, required: true
    argument :description, String, required: false
    argument :ingredients, [RecipeIngredientInputType], required: false
    argument :equipments, [RecipeEquipmentInputType], required: false
    argument :steps, [String], required: false
  end
end
