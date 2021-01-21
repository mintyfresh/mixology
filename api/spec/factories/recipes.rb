# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id               :bigint           not null, primary key
#  author_id        :bigint           not null
#  name             :citext           not null
#  description      :string
#  favourites_count :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#
# Indexes
#
#  index_recipes_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#
FactoryBot.define do
  factory :recipe do
    association :author, factory: :user, strategy: :build

    name { Faker::Food.dish }
    description { Faker::Food.description }

    trait :deleted do
      deleted { true }
    end

    trait :with_ingredients do
      transient do
        ingredients_count { 3 }
      end

      after(:build) do |recipe, e|
        recipe.ingredients = build_list(:ingredient, e.ingredients_count)
      end
    end

    trait :with_equipments do
      transient do
        equipments_count { 3 }
      end

      after(:build) do |recipe, e|
        recipe.equipments = build_list(:equipment, e.equipments_count)
      end
    end

    trait :with_steps do
      transient do
        steps_count { 3 }
      end

      after(:build) do |recipe, e|
        recipe.steps = build_list(:recipe_step, e.steps_count)
      end
    end
  end
end
