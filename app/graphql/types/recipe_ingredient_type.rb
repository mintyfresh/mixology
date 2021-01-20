# frozen_string_literal: true

module Types
  class RecipeIngredientType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :quantity_amount, Float, null: true
    field :quantity_unit, String, null: true

    def name
      Loaders::AssociationLoader.for(RecipeIngredient, :ingredient).load(object).then(&:name)
    end
  end
end
