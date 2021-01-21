# frozen_string_literal: true

# == Schema Information
#
# Table name: equipment
#
#  id         :bigint           not null, primary key
#  name       :citext           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_equipment_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :equipment do
    sequence(:name) { |n| "#{Faker::Lorem.word} #{n}" }
  end
end
