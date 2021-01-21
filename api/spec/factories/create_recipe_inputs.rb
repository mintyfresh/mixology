# frozen_string_literal: true

FactoryBot.define do
  factory :create_recipe_input, class: 'Types::CreateRecipeInputType' do
    skip_create

    initialize_with do
      Types::CreateRecipeInputType.to_graphql

      arguments = Types::CreateRecipeInputType.arguments_class.new(attributes, context: nil, defaults_used: Set.new)

      Types::CreateRecipeInputType.new(ruby_kwargs: arguments.to_kwargs, context: nil, defaults_used: Set.new)
    end

    name { Faker::Food.dish }

    trait :invalid do
      name { '' }
    end

    trait :with_description do
      description { Faker::Food.description }
    end

    trait :with_ingredients do
      transient do
        ingredients_count { 3 }
      end

      ingredients { build_list(:ingredient_fragment, ingredients_count) }
    end

    trait :with_equipment do
      transient do
        equipments_count { 3 }
      end

      equipments { build_list(:equipment_fragment, equipments_count) }
    end

    trait :with_steps do
      transient do
        steps_count { 3 }
      end

      steps { Array.new(steps_count) { Faker::Hipster.sentence } }
    end
  end

  factory :ingredient_fragment, class: 'Hash' do
    skip_create
    initialize_with { attributes }

    sequence(:name) { |n| "#{Faker::Food.ingredient} #{n}" }

    trait :with_quantity do
      quantity_amount { rand(1..100) }
      quantity_unit { RecipeIngredient::SUPPORTED_UNITS.sample }
    end
  end

  factory :equipment_fragment, class: 'Hash' do
    skip_create
    initialize_with { attributes }

    sequence(:name) { |n| "#{Faker::Lorem.word} #{n}" }

    trait :with_quantity do
      quantity { rand(1..100) }
    end
  end
end
