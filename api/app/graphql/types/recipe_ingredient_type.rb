# frozen_string_literal: true

module Types
  class RecipeIngredientType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :quantity, String, null: true
    field :quantity_amount, Float, null: true
    field :quantity_unit, String, null: true

    def name
      Loaders::AssociationLoader.for(RecipeIngredient, :ingredient).load(object).then(&:name)
    end

    # @return [String]
    def quantity
      return if object.quantity_amount.nil?

      amount = helpers.number_to_human(object.quantity_amount)
      return amount if object.quantity_unit.nil?

      "#{amount} #{object.quantity_unit.pluralize}"
    end
  end
end
