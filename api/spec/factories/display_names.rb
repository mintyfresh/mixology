# frozen_string_literal: true

FactoryBot.define do
  sequence(:display_name) do |n|
    "#{Faker::Internet.user_name}.#{n}"
  end
end
