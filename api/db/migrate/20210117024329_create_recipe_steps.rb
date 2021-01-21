# frozen_string_literal: true

class CreateRecipeSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_steps do |t|
      t.belongs_to :recipe, null: false, foreign_key: true
      t.string     :body, null: false
      t.integer    :position, null: false
      t.timestamps default: -> { 'NOW()' }
    end
  end
end
