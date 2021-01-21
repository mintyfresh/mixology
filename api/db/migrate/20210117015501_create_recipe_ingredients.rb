# frozen_string_literal: true

class CreateRecipeIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_ingredients do |t|
      t.belongs_to :recipe, null: false, foreign_key: true
      t.belongs_to :ingredient, null: false, foreign_key: true
      t.float      :quantity_amount
      t.string     :quantity_unit
      t.timestamps default: -> { 'NOW()' }

      t.index %i[recipe_id ingredient_id], unique: true
    end
  end
end
