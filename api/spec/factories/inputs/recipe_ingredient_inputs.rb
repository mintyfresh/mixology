# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_ingredient_input, class: 'Hash' do
    skip_create
    initialize_with { attributes }

    sequence(:name) { |n| "#{Faker::Food.ingredient} #{n}" }

    trait :with_quantity do
      quantity_amount { rand(1..100) }
      quantity_unit { RecipeIngredient::SUPPORTED_UNITS.sample }
    end

    trait :optional do
      optional { true }
    end
  end
end
