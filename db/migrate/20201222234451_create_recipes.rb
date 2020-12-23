# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.belongs_to :author, null: false, foreign_key: { to_table: :users }
      t.string     :name, null: false
      t.string     :description
      t.timestamps default: -> { 'NOW()' }
    end
  end
end
