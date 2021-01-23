# frozen_string_literal: true

FactoryBot.define do
  factory :sign_up_input, class: 'Types::SignUpInputType' do
    skip_create

    initialize_with do
      Types::SignUpInputType.to_graphql

      attributes = self.attributes.transform_keys { |key| key.to_s.camelize(:lower) }
      arguments  = Types::SignUpInputType.arguments_class.new(attributes, context: nil, defaults_used: Set.new)

      Types::SignUpInputType.new(ruby_kwargs: arguments.to_kwargs, context: nil, defaults_used: Set.new)
    end

    email { Faker::Internet.email }
    display_name { Faker::Internet.username }
    password { Faker::Internet.password }
    password_confirmation { password }
    date_of_birth { Faker::Date.between(from: 80.years.ago, to: 20.years.ago) }

    trait :invalid do
      email { '' }
    end
  end
end
