# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id         :bigint           not null, primary key
#  name       :citext           not null
#  data       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Ingredient < ApplicationRecord
  has_many :recipe_ingredients, dependent: :destroy, inverse_of: :ingredient
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true
end
