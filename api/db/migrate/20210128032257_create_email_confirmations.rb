# frozen_string_literal: true

class CreateEmailConfirmations < ActiveRecord::Migration[6.1]
  def change
    create_table :email_confirmations do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.citext     :email, null: false
      t.timestamp  :expires_at, null: false
      t.timestamp  :completed_at
      t.timestamps default: -> { 'NOW()' }
    end
  end
end
