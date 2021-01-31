# frozen_string_literal: true

# == Schema Information
#
# Table name: password_resets
#
#  id            :bigint           not null, primary key
#  user_id       :bigint
#  email         :citext           not null
#  expires_at    :datetime         not null
#  email_sent_at :datetime
#  completed_at  :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_password_resets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :password_reset do
    association :user, strategy: :build

    email { user.email }

    trait :without_user do
      user { nil }
      email { Faker::Internet.email }
    end

    trait :expired do
      expires_at { 5.minutes.ago }
    end

    trait :email_sent do
      email_sent_at { 5.minutes.ago }
    end

    trait :completed do
      completed_at { 5.minutes.ago }
    end
  end
end
