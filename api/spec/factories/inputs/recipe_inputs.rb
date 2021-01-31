# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_input, class: 'Types::RecipeInputType' do
    skip_create

    initialize_with do
      Types::RecipeInputType.to_graphql

      arguments = Types::RecipeInputType.arguments_class.new(attributes, context: nil, defaults_used: Set.new)

      Types::RecipeInputType.new(ruby_kwargs: arguments.to_kwargs, context: nil, defaults_used: Set.new)
    end

    name { Faker::Food.dish }
    description { Faker::Food.description }

    trait :invalid do
      name { '' }
    end

    trait :with_ingredients do
      transient do
        ingredients_count { 3 }
      end

      ingredients { build_list(:recipe_ingredient_input, ingredients_count) }
    end

    trait :with_equipment do
      transient do
        equipments_count { 3 }
      end

      equipments { build_list(:recipe_equipment_input, equipments_count) }
    end

    trait :with_steps do
      transient do
        steps_count { 3 }
      end

      steps { Array.new(steps_count) { Faker::Hipster.sentence } }
    end
  end
end
