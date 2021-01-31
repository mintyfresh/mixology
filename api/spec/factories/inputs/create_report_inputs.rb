# frozen_string_literal: true

FactoryBot.define do
  factory :create_report_input, class: 'Types::CreateReportInputType' do
    skip_create

    initialize_with do
      Types::CreateReportInputType.build_from_attributes(attributes)
    end

    message { Faker::Hipster.sentence }

    trait :invalid do
      message { '' }
    end
  end
end
