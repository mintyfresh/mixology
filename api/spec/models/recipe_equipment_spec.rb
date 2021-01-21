# frozen_string_literal: true

# == Schema Information
#
# Table name: recipe_equipments
#
#  id           :bigint           not null, primary key
#  recipe_id    :bigint           not null
#  equipment_id :bigint           not null
#  quantity     :integer
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
require 'rails_helper'

RSpec.describe RecipeEquipment, type: :model do
  subject(:recipe_equipment) { build(:recipe_equipment) }

  it 'has a valid factory' do
    expect(recipe_equipment).to be_valid
  end

  it 'is invalid without a recipe' do
    recipe_equipment.recipe = nil
    expect(recipe_equipment).to be_invalid
  end

  it 'is invalid without an equipment' do
    recipe_equipment.equipment = nil
    expect(recipe_equipment).to be_invalid
  end

  it 'is valid without a quantity' do
    recipe_equipment.quantity = nil
    expect(recipe_equipment).to be_valid
  end

  it 'is invalid when the quantity is zero' do
    recipe_equipment.quantity = 0
    expect(recipe_equipment).to be_invalid
  end

  it 'is invalid when the quantity is negative' do
    recipe_equipment.quantity = -1
    expect(recipe_equipment).to be_invalid
  end
end
