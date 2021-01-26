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
class Review < ApplicationRecord
  include SoftDeletable

  BODY_MIN_LENGTH = 5
  BODY_MAX_LENGTH = 10_000
  RATING_RANGE    = 1..5

  belongs_to :recipe, counter_cache: true, inverse_of: :reviews
  belongs_to :author, class_name: 'User', inverse_of: :authored_reviews

  has_unique_attribute :recipe, index: 'index_reviews_on_recipe_id_and_author_id'

  validates :body, length: { minimum: BODY_MIN_LENGTH, maximum: BODY_MAX_LENGTH }
  validates :rating, inclusion: { in: RATING_RANGE }

  after_save :update_recipe_average_rating, if: :saved_change_to_rating?

private

  # @return [void]
  def update_recipe_average_rating
    recipe.update_average_rating!
  end
end
