# frozen_string_literal: true

module Types
  class RecipeType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :ingredients, [String], null: false
    field :equipments, [String], null: false
    field :steps, [String], null: false

    def ingredients
      object.ingredients.map(&:name)
    end

    def equipments
      object.equipments.map(&:name)
    end

    def steps
      object.steps.map(&:body)
    end
  end
end
