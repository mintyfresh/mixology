# frozen_string_literal: true

# == Schema Information
#
# Table name: equipment
#
#  id         :bigint           not null, primary key
#  name       :citext           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_equipment_on_name  (name) UNIQUE
#
class Equipment < ApplicationRecord
  NAME_MAX_LENGTH = 100

  has_many :recipe_equipments, dependent: :destroy, inverse_of: :equipment
  has_many :recipes, through: :recipe_equipments

  validates :name, presence: true, length: { maximum: NAME_MAX_LENGTH }
end
