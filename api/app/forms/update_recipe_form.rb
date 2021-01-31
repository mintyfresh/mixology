# frozen_string_literal: true

class UpdateRecipeForm < BaseRecipeForm
  attribute :recipe, Types::Instance(Recipe)

  validates :recipe, presence: true

  # @return [Recipe]
  def perform
    super do
      recipe.update!(recipe_attributes)

      recipe
    end
  end
end
