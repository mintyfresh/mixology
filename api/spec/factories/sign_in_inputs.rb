# frozen_string_literal: true

FactoryBot.define do
  factory :sign_in_input, class: 'Types::SignInInputType' do
    skip_create

    initialize_with do
      Types::SignInInputType.to_graphql

      arguments = Types::SignInInputType.arguments_class.new(attributes, context: nil, defaults_used: Set.new)

      Types::SignInInputType.new(ruby_kwargs: arguments.to_kwargs, context: nil, defaults_used: Set.new)
    end

    email { user.email }
    password { Faker::Internet.password }

    transient do
      user { create(:user, :with_password, password: password) }
    end

    trait :invalid do
      incorrect_password
    end

    trait :incorrect_email do
      email { Faker::Internet.email }
    end

    trait :incorrect_password do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
    end
  end
end
