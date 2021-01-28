# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :citext           not null
#  email_confirmed :boolean          default(FALSE), not null
#  display_name    :citext           not null
#  date_of_birth   :date             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_display_name  (display_name) UNIQUE
#  index_users_on_email         (email) UNIQUE
#
FactoryBot.define do
  factory :user do
    email
    display_name
    date_of_birth { Faker::Date.between(from: 80.years.ago, to: 20.years.ago) }

    trait :email_confirmed do
      email_confirmed { true }
    end

    trait :with_password do
      transient do
        password { Faker::Internet.password }
      end

      after(:build) do |user, e|
        user.credentials << build(:user_password_credential, user: user, password: e.password)
      end
    end

    trait :with_email_confirmation do
      after(:build) do |user|
        user.email_confirmations << build(:email_confirmation, user: user, email: user.email)
      end
    end
  end
end
