# frozen_string_literal: true

# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  recipe_id  :bigint           not null
#  author_id  :bigint           not null
#  body       :string           not null
#  rating     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#
# Indexes
#
#  index_reviews_on_author_id                (author_id)
#  index_reviews_on_recipe_id                (recipe_id)
#  index_reviews_on_recipe_id_and_author_id  (recipe_id,author_id) UNIQUE WHERE (deleted_at IS NULL)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (recipe_id => recipes.id)
#
FactoryBot.define do
  factory :review do
    association :recipe, strategy: :build
    association :author, factory: :user, strategy: :build

    body { Faker::Hipster.paragraph }
    rating { rand(1..5) }
  end
end
