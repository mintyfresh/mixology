# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id         :bigint           not null, primary key
#  name       :citext           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ingredients_on_name  (name) UNIQUE
#
class Ingredient < ApplicationRecord
  NAME_MAX_LENGTH = 100

  has_many :recipe_ingredients, dependent: :destroy, inverse_of: :ingredient
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true, length: { maximum: NAME_MAX_LENGTH }
end
