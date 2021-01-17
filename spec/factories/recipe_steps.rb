# frozen_string_literal: true

# == Schema Information
#
# Table name: recipe_steps
#
#  id         :bigint           not null, primary key
#  recipe_id  :bigint           not null
#  body       :string           not null
#  position   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_recipe_steps_on_recipe_id  (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id)
#
FactoryBot.define do
  factory :recipe_step do
    association :recipe, strategy: :build

    body { Faker::Hipster.paragraph }
    sequence(:position) { |n| n }
  end
end
