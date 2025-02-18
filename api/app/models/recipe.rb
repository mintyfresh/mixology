# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id               :bigint           not null, primary key
#  author_id        :bigint           not null
#  name             :citext           not null
#  description      :string
#  favourites_count :integer          default(0), not null
#  average_rating   :float            default(0.0), not null
#  reviews_count    :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#
# Indexes
#
#  index_recipes_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#
class Recipe < ApplicationRecord
  include Favouriteable
  include Reportable
  include SoftDeletable

  NAME_MAX_LENGTH        = 100
  DESCRIPTION_MAX_LENGTH = 2500
  INGREDIENTS_MAX_LENGTH = 25
  EQUIPMENTS_MAX_LENGTH  = 25
  STEPS_MAX_LENGTH       = 50

  belongs_to :author, class_name: 'User', inverse_of: :authored_recipes

  has_many :recipe_ingredients, dependent: :destroy, inverse_of: :recipe
  has_many :ingredients, through: :recipe_ingredients

  has_many :recipe_equipments, dependent: :destroy, inverse_of: :recipe
  has_many :equipments, through: :recipe_equipments

  has_many :steps, -> { order(:position) },
           autosave: true, class_name: 'RecipeStep', dependent: :destroy, inverse_of: :recipe

  has_many :reviews, dependent: :destroy, inverse_of: :recipe

  validates :name, presence: true, length: { maximum: NAME_MAX_LENGTH }
  validates :description, length: { maximum: DESCRIPTION_MAX_LENGTH }

  # @return [String]
  def slug
    "#{name.parameterize}-#{id}"
  end

  # @return [Boolean]
  def update_average_rating!
    update!(average_rating: reviews.average(:rating) || 0)
  end
end
