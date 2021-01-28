# frozen_string_literal: true

# == Schema Information
#
# Table name: email_confirmations
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  email        :citext           not null
#  expires_at   :datetime         not null
#  confirmed_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_email_confirmations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :email_confirmation do
    association :user, strategy: :build

    email { user.email }

    trait :expired do
      expires_at { 5.minutes.ago }
    end

    trait :confirmed do
      confirmed_at { 5.minutes.ago }
    end

    trait :stale do
      email { Faker::Internet.email }
    end
  end
end
