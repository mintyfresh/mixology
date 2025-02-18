# frozen_string_literal: true

# == Schema Information
#
# Table name: recipe_ingredients
#
#  id              :bigint           not null, primary key
#  recipe_id       :bigint           not null
#  ingredient_id   :bigint           not null
#  quantity_amount :float
#  quantity_unit   :string
#  optional        :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_recipe_ingredients_on_ingredient_id                (ingredient_id)
#  index_recipe_ingredients_on_recipe_id                    (recipe_id)
#  index_recipe_ingredients_on_recipe_id_and_ingredient_id  (recipe_id,ingredient_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (ingredient_id => ingredients.id)
#  fk_rails_...  (recipe_id => recipes.id)
#
FactoryBot.define do
  factory :recipe_ingredient do
    association :recipe, strategy: :build
    association :ingredient, strategy: :build

    trait :with_quantity do
      quantity_amount { rand(1..100) }
      quantity_unit { RecipeEquipment::SUPPORTED_UNITS.sample }
    end

    trait :optional do
      optional { true }
    end
  end
end
