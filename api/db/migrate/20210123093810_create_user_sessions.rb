# frozen_string_literal: true

class CreateUserSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_sessions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.timestamp  :expires_at, null: false
      t.timestamp  :revoked_at
      t.inet       :creation_ip
      t.string     :creation_user_agent
      t.timestamps default: -> { 'NOW()' }
    end
  end
end
