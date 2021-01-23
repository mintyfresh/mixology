# frozen_string_literal: true

# == Schema Information
#
# Table name: user_credentials
#
#  id         :bigint           not null, primary key
#  type       :string           not null
#  user_id    :bigint           not null
#  data       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_credentials_on_type_and_user_id  (type,user_id) UNIQUE
#  index_user_credentials_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_credential do
    association :user, strategy: :build
  end
end
