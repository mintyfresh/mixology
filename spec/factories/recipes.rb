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
FactoryBot.define do
  factory :recipe do
    association :author, factory: :user, strategy: :build

    name { Faker::Food.dish }
    description { Faker::Food.description }

    trait :with_ingredients do
      transient do
        ingredients_count { 3 }
      end

      after(:build) do |recipe, e|
        recipe.ingredients = build_list(:ingredient, e.ingredients_count)
      end
    end
  end
end
