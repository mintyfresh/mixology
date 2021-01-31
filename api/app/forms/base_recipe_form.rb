# frozen_string_literal: true

class BaseRecipeForm < ApplicationForm
  attribute :name, Types::StrippedString
  attribute :description, Types::StrippedString
  attribute :ingredients, Types::Array.of(Fragments::RecipeIngredientFragment), default: -> { [] }
  attribute :equipments, Types::Array.of(Fragments::RecipeEquipmentFragment), default: -> { [] }
  attribute :steps, Types::Array.of(Types::StrippedString), default: -> { [] }

  validates :name, presence: true, length: { maximum: Recipe::NAME_MAX_LENGTH }
  validates :description, length: { maximum: Recipe::DESCRIPTION_MAX_LENGTH }
  validates :ingredients, nested: true, length: { maximum: Recipe::INGREDIENTS_MAX_LENGTH }
  validates :equipments, nested: true, length: { maximum: Recipe::EQUIPMENTS_MAX_LENGTH }
  validates :steps, length: { maximum: Recipe::STEPS_MAX_LENGTH }

  # @abstract
  # @return [Recipe]
  def perform(&block)
    transaction(&block)
  end

protected

  # @return [Hash]
  def recipe_attributes
    {
      name:               name,
      description:        description,
      recipe_ingredients: build_recipe_ingredients,
      recipe_equipments:  build_recipe_equipments,
      steps:              build_recipe_steps
    }
  end

private

  # @return [Array<RecipeIngredient>]
  def build_recipe_ingredients
    ingredients.map(&:build_recipe_ingredient)
  end

  # @return [Array<RecipeEquipment>]
  def build_recipe_equipments
    equipments.map(&:build_recipe_equipment)
  end

  # @return [Array<RecipeStep>]
  def build_recipe_steps
    steps.map.with_index do |step, index|
      RecipeStep.new(body: step, position: index)
    end
  end
end
