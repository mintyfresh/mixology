# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.belongs_to :author, null: false, foreign_key: { to_table: :users }
      t.citext     :name, null: false
      t.string     :description
      t.timestamps default: -> { 'NOW()' }
      t.timestamp  :deleted_at
    end
  end
end
