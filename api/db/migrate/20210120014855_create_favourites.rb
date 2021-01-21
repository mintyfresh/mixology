# frozen_string_literal: true

class CreateFavourites < ActiveRecord::Migration[6.1]
  def change
    create_table :favourites do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :favouriteable, null: false, polymorphic: true
      t.timestamps default: -> { 'NOW()' }

      t.index %i[user_id favouriteable_type favouriteable_id],
              name:   'index_favourites_on_user_and_favouriteable',
              unique: true
    end
  end
end
