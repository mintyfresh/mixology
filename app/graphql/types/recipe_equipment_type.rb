# frozen_string_literal: true

module Types
  class RecipeEquipmentType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :quantity, Integer, null: true

    def name
      Loaders::AssociationLoader.for(RecipeEquipment, :equipment).load(object).then(&:name)
    end
  end
end
