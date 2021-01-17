# frozen_string_literal: true

module Types
  class CreateRecipeInputType < BaseInputObject
    class EquipmentInputType < BaseInputObject
      graphql_name 'CreateRecipeInput_EquipmentInput'

      argument :name, String, required: true
      argument :quantity, Integer, required: false
    end

    argument :name, String, required: true
    argument :description, String, required: false
    argument :ingredients, [String], required: false
    argument :equipments, [EquipmentInputType], required: false
    argument :steps, [String], required: false
  end
end
