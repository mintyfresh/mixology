# frozen_string_literal: true

class CreateRecipeEquipments < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_equipments do |t|
      t.belongs_to :recipe, null: false, foreign_key: true
      t.belongs_to :equipment, null: false, foreign_key: true
      t.integer    :quantity
      t.timestamps default: -> { 'NOW()' }

      t.index %i[recipe_id equipment_id], unique: true
    end
  end
end
