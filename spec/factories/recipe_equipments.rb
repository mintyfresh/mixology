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
FactoryBot.define do
  factory :recipe_equipment do
    association :recipe, strategy: :build
    association :equipment, strategy: :build

    trait :with_quantity do
      quantity { rand(1..10) }
    end
  end
end
