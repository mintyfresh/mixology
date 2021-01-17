# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id          :bigint           not null, primary key
#  author_id   :bigint           not null
#  name        :string           not null
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_recipes_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#
class Recipe < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :recipes

  has_many :recipe_ingredients, dependent: :destroy, inverse_of: :recipe
  has_many :ingredients, through: :recipe_ingredients

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 2500 }
end
