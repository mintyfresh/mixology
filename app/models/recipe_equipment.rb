# frozen_string_literal: true

# == Schema Information
#
# Table name: recipe_equipments
#
#  id           :bigint           not null, primary key
#  recipe_id    :bigint           not null
#  equipment_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_recipe_equipments_on_equipment_id                (equipment_id)
#  index_recipe_equipments_on_recipe_id                   (recipe_id)
#  index_recipe_equipments_on_recipe_id_and_equipment_id  (recipe_id,equipment_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (equipment_id => equipment.id)
#  fk_rails_...  (recipe_id => recipes.id)
#
class RecipeEquipment < ApplicationRecord
  belongs_to :recipe, inverse_of: :recipe_equipments
  belongs_to :equipment, inverse_of: :recipe_equipments
end
