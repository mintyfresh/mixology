# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_equipment_input, class: 'Hash' do
    skip_create
    initialize_with { attributes }

    sequence(:name) { |n| "#{Faker::Lorem.word} #{n}" }

    trait :with_quantity do
      quantity { rand(1..100) }
    end
  end
end
