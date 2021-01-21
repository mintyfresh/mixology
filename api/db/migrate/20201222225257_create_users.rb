# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'citext'

    create_table :users do |t|
      t.citext     :email, null: false, index: { unique: true }
      t.citext     :display_name, null: false, index: { unique: true }
      t.date       :date_of_birth, null: false
      t.timestamps default: -> { 'NOW()' }
    end
  end
end
