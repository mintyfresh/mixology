# frozen_string_literal: true

# == Schema Information
#
# Table name: user_sessions
#
#  id                  :bigint           not null, primary key
#  user_id             :bigint           not null
#  expires_at          :datetime         not null
#  revoked_at          :datetime
#  creation_ip         :inet
#  creation_user_agent :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_user_sessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_session do
    association :user, strategy: :build

    creation_ip { Faker::Internet.ip_v4_address }
    creation_user_agent { Faker::Internet.user_agent }

    trait :expired do
      expires_at { 5.minutes.ago }
    end

    trait :revoked do
      revoked_at { 5.minutes.ago }
    end
  end
end
