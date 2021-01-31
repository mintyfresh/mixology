# frozen_string_literal: true

class CreateRecipeForm < ApplicationForm
  class IngredientFragment < Fragment
    attribute :name, Types::StrippedString
    attribute :quantity_amount, Types::Integer | Types::Float
    attribute :quantity_unit, Types::String
    attribute :optional, Types::Boolean, default: false

    validates :name, presence: true, length: { maximum: Ingredient::NAME_MAX_LENGTH }
    validates :quantity_amount, numericality: { allow_nil: true, greater_than: 0 }
    validates :quantity_unit, inclusion: { in: RecipeIngredient::SUPPORTED_UNITS }

    # @return [RecipeIngredient]
    def build_recipe_ingredient
      RecipeIngredient.new(
        ingredient:      Ingredient.create_or_find_by!(name: name),
        quantity_amount: quantity_amount,
        quantity_unit:   quantity_unit,
        optional:        optional
      )
    end
  end

  class EquipmentFragment < Fragment
    attribute :name, Types::StrippedString
    attribute :quantity, Types::Integer

    validates :name, presence: true, length: { maximum: Equipment::NAME_MAX_LENGTH }
    validates :quantity, numericality: { allow_nil: true, greater_than: 0 }

    # @return [RecipeEquipment]
    def build_recipe_equipment
      RecipeEquipment.new(
        equipment: Equipment.create_or_find_by!(name: name),
        quantity:  quantity
      )
    end
  end

  attribute :author, Types::Instance(User)
  attribute :name, Types::StrippedString
  attribute :description, Types::StrippedString
  attribute :ingredients, Types::Array.of(IngredientFragment), default: -> { [] }
  attribute :equipments, Types::Array.of(EquipmentFragment), default: -> { [] }
  attribute :steps, Types::Array.of(Types::StrippedString), default: -> { [] }

  validates :author, presence: true
  validates :name, presence: true, length: { maximum: Recipe::NAME_MAX_LENGTH }
  validates :description, length: { maximum: Recipe::DESCRIPTION_MAX_LENGTH }
  validates :ingredients, nested: true, length: { maximum: Recipe::INGREDIENTS_MAX_LENGTH }
  validates :equipments, nested: true, length: { maximum: Recipe::EQUIPMENTS_MAX_LENGTH }
  validates :steps, length: { maximum: Recipe::STEPS_MAX_LENGTH }

  def perform
    transaction do
      Recipe.create!(
        author:             author,
        name:               name,
        description:        description,
        recipe_ingredients: build_recipe_ingredients,
        recipe_equipments:  build_recipe_equipments,
        steps:              build_recipe_steps
      )
    end
  end

private

  # @return [Array<Ingredient>]
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
