# frozen_string_literal: true

class CreatePasswordResets < ActiveRecord::Migration[6.1]
  def change
    create_table :password_resets do |t|
      t.belongs_to :user, null: true, foreign_key: true
      t.citext     :email, null: false
      t.timestamp  :expires_at, null: false
      t.timestamp  :email_sent_at
      t.timestamp  :completed_at
      t.timestamps default: -> { 'NOW()' }
    end
  end
end
