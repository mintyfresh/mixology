# frozen_string_literal: true

module Types
  class CreateRecipeInputType < BaseInputObject
    argument :name, String, required: true
    argument :description, String, required: false
    argument :ingredients, [String], required: false
    argument :equipments, [String], required: false
    argument :steps, [String], required: false
  end
end
