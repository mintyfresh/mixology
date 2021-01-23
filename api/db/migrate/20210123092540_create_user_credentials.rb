# frozen_string_literal: true

class CreateUserCredentials < ActiveRecord::Migration[6.1]
  def change
    create_table :user_credentials do |t|
      t.string     :type, null: false
      t.belongs_to :user, null: false, foreign_key: true
      t.jsonb      :data, null: false, default: {}
      t.timestamps default: -> { 'NOW()' }

      t.index %i[type user_id], unique: true
    end
  end
end
