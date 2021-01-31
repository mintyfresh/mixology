# frozen_string_literal: true

module Fragments
  class RecipeEquipmentFragment < ApplicationFragment
    attribute :name, Types::StrippedString
    attribute :quantity, Types::Integer

    validates :name, presence: true, length: { maximum: Equipment::NAME_MAX_LENGTH }
    validates :quantity, numericality: { allow_nil: true, greater_than: 0 }

    # @return [RecipeEquipment]
    def build_recipe_equipment
      RecipeEquipment.new(
        equipment: Equipment.create_or_find_by!(name: name),
        quantity:  quantity
      )
    end
  end
end
