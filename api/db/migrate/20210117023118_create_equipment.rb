# frozen_string_literal: true

class CreateEquipment < ActiveRecord::Migration[6.1]
  def change
    create_table :equipment do |t|
      t.citext     :name, null: false, index: { unique: true }
      t.timestamps default: -> { 'NOW()' }
    end
  end
end
