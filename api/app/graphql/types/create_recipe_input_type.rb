# frozen_string_literal: true

module Types
  class CreateRecipeInputType < BaseInputObject
    class IngredientInputType < BaseInputObject
      graphql_name 'CreateRecipeInput_IngredientInput'

      argument :name, String, required: true
      argument :quantity_amount, Float, required: false
      argument :quantity_unit, String, required: false
      argument :optional, Boolean, required: true
    end

    class EquipmentInputType < BaseInputObject
      graphql_name 'CreateRecipeInput_EquipmentInput'

      argument :name, String, required: true
      argument :quantity, Integer, required: false
    end

    argument :name, String, required: true
    argument :description, String, required: false
    argument :ingredients, [IngredientInputType], required: false
    argument :equipments, [EquipmentInputType], required: false
    argument :steps, [String], required: false
  end
end
