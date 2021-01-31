# frozen_string_literal: true

class CreateRecipeForm < BaseRecipeForm
  attribute :author, Types::Instance(User)

  validates :author, presence: true

  # @return [Recipe]
  def perform
    super do
      Recipe.create!(**recipe_attributes, author: author)
    end
  end
end
