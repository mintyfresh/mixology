# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.belongs_to :recipe, null: false, foreign_key: true
      t.belongs_to :author, null: false, foreign_key: { to_table: :users }
      t.string     :body, null: false
      t.integer    :rating, null: false
      t.timestamps default: -> { 'NOW()' }
      t.timestamp  :deleted_at

      t.index %i[recipe_id author_id], unique: true, where: 'deleted_at IS NULL'
    end
  end
end
