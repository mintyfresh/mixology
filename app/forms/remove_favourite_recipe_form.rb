# frozen_string_literal: true

class RemoveFavouriteRecipeForm < ApplicationForm
  attribute :user, Types::Instance(User)
  attribute :recipe, Types::Instance(Recipe)

  validates :user, :recipe, presence: true
  validate  :user_is_not_recipe_author, if: -> { user && recipe }

  # @return [Recipe]
  def perform
    recipe.remove_favourite(user)

    recipe
  end

private

  # @return [void]
  def user_is_not_recipe_author
    errors.add(:base, :cannot_favourite_own_recipe) if recipe.author == user
  end
end
