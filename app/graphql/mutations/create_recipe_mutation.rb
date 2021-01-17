# frozen_string_literal: true

module Mutations
  class CreateRecipeMutation < BaseMutation
    argument :input, Types::CreateRecipeInputType, required: true

    field :recipe, Types::RecipeType, null: true
    field :errors, [Types::ValidationErrorType], null: true

    def resolve(input:)
      Recipe.transaction do
        recipe = build_recipe(input)

        if recipe.save
          { recipe: recipe }
        else
          { errors: recipe.errors }
        end
      end
    end

  private

    # @return [Recipe]
    def build_recipe(input)
      Recipe.new(
        author:             current_user,
        name:               input.name,
        description:        input.description,
        recipe_ingredients: build_recipe_ingredients(input),
        recipe_equipments:  build_recipe_equipments(input),
        steps:              build_recipe_steps(input)
      )
    end

    # @return [Array<Ingredient>]
    def build_recipe_ingredients(input)
      return [] if input.ingredients.blank?

      input.ingredients.uniq(&:name).map do |ingredient|
        RecipeIngredient.new(
          ingredient:      Ingredient.create_or_find_by!(name: ingredient.name),
          quantity_amount: ingredient.quantity_amount,
          quantity_unit:   ingredient.quantity_unit
        )
      end
    end

    # @return [Array<RecipeEquipment>]
    def build_recipe_equipments(input)
      return [] if input.equipments.blank?

      input.equipments.uniq(&:name).map do |equipment|
        RecipeEquipment.new(
          equipment: Equipment.create_or_find_by!(name: equipment.name),
          quantity:  equipment.quantity
        )
      end
    end

    # @return [Array<RecipeStep>]
    def build_recipe_steps(input)
      return [] if input.steps.blank?

      input.steps.map.with_index do |step, index|
        RecipeStep.new(body: step, position: index)
      end
    end
  end
end
