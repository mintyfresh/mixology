# frozen_string_literal: true

FactoryBot.define do
  factory :perform_password_reset_input, class: 'Types::PerformPasswordResetInputType' do
    skip_create

    initialize_with do
      Types::PerformPasswordResetInputType.build_from_attributes(attributes)
    end

    new_password { Faker::Internet.password }
    new_password_confirmation { new_password }

    trait :invalid do
      new_password { '' }
    end
  end
end
