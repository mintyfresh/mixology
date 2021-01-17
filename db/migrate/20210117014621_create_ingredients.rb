# frozen_string_literal: true

class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.citext     :name, null: false
      t.jsonb      :data, null: false, default: {}
      t.timestamps default: -> { 'NOW()' }
    end
  end
end
