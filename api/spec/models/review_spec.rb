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
require 'rails_helper'

RSpec.describe Review, type: :model do
  subject(:review) { build(:review) }

  it 'has a valid factory' do
    expect(review).to be_valid
  end

  it 'is invalid without a recipe' do
    review.recipe = nil
    expect(review).to be_invalid
  end

  it 'is invalid without a author' do
    review.author = nil
    expect(review).to be_invalid
  end

  it 'is invalid without a body' do
    review.body = nil
    expect(review).to be_invalid
  end

  it 'is invalid when the body is too short' do
    review.body = 'a' * (described_class::BODY_MIN_LENGTH - 1)
    expect(review).to be_invalid
  end

  it 'is invalid when the body is too long' do
    review.body = 'a' * (described_class::BODY_MAX_LENGTH + 1)
    expect(review).to be_invalid
  end

  it 'is invalid without a rating' do
    review.rating = nil
    expect(review).to be_invalid
  end

  it 'is invalid with an unsupported rating' do
    review.rating = 6
    expect(review).to be_invalid
  end
end
