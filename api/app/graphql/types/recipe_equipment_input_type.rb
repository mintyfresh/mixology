# frozen_string_literal: true

module Types
  class RecipeEquipmentInputType < BaseInputObject
    argument :name, String, required: true
    argument :quantity, Integer, required: false
  end
end
