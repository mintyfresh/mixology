# frozen_string_literal: true

FactoryBot.define do
  factory :graphql_context, class: 'Hash' do
    skip_create

    initialize_with { attributes }

    current_session { current_user && create(:user_session, user: current_user) }
    ip { Faker::Internet.ip_v4_address }
    user_agent { Faker::Internet.user_agent }

    transient do
      current_user { create(:user) }
    end

    trait :guest do
      current_user { nil }
    end

    trait :ip_v6 do
      ip { Faker::Internet.ip_v6_address }
    end
  end
end
