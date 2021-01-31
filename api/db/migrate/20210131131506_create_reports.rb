# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.belongs_to :author, null: false, foreign_key: { to_table: :users }
      t.belongs_to :reportable, polymorphic: true, null: false
      t.string     :message, null: false
      t.timestamps default: -> { 'NOW()' }
    end
  end
end
