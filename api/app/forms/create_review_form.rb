# frozen_string_literal: true

class CreateReviewForm < ApplicationForm
  attribute :recipe, Types::Instance(Recipe)
  attribute :author, Types::Instance(User)

  attribute :body, Types::StrippedString
  attribute :rating, Types::Integer

  validates :author, :recipe, presence: true
  validates :body, length: { minimum: Review::BODY_MIN_LENGTH, maximum: Review::BODY_MAX_LENGTH }
  validates :rating, inclusion: { in: Review::RATING_RANGE }
  validate  :author_is_not_recipe_author, if: -> { author && recipe }

  # @return [Review]
  def perform
    recipe.reviews.create!(author: author, body: body, rating: rating)
  end

private

  # @return [void]
  def author_is_not_recipe_author
    errors.add(:base, :cannot_review_own_recipe) if recipe.author == author
  end
end
