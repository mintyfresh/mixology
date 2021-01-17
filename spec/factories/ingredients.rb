# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id         :bigint           not null, primary key
#  name       :citext           not null
#  data       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :ingredient do
    name { Faker::Food.ingredient }
  end
end
