# frozen_string_literal: true

FactoryBot.define do
  factory :change_password_input, class: 'Types::ChangePasswordInputType' do
    skip_create

    initialize_with do
      Types::ChangePasswordInputType.to_graphql

      attributes = self.attributes.transform_keys { |key| key.to_s.camelize(:lower) }
      arguments  = Types::ChangePasswordInputType.arguments_class.new(attributes, context: nil, defaults_used: Set.new)

      Types::ChangePasswordInputType.new(ruby_kwargs: arguments.to_kwargs, context: nil, defaults_used: Set.new)
    end

    old_password { Faker::Internet.password }
    new_password { Faker::Internet.password }
    new_password_confirmation { new_password }

    trait :invalid do
      old_password { '' }
    end
  end
end
