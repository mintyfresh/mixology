# frozen_string_literal: true

module Mutations
  class CreateRecipeMutation < BaseMutation
    argument :input, Types::CreateRecipeInputType, required: true

    field :recipe, Types::RecipeType, null: true
    field :errors, [String], null: true

    def resolve(input:)
      Recipe.transaction do
        recipe = build_recipe(input)

        if recipe.save
          { recipe: recipe }
        else
          { errors: recipe.errors.full_messages }
        end
      end
    end

  private

    # @return [Recipe]
    def build_recipe(input)
      Recipe.new(
        author:      current_user,
        name:        input.name,
        description: input.description,
        ingredients: build_ingredients(input),
        equipments:  build_equipments(input),
        steps:       build_steps(input)
      )
    end

    # @return [Array<Ingredient>]
    def build_ingredients(input)
      return [] if input.ingredients.blank?

      ingredients = input.ingredients.reject(&:blank?)
      return [] if ingredients.empty?

      ingredients.uniq.map do |ingredient|
        Ingredient.create_or_find_by!(name: ingredient)
      end
    end

    # @return [Array<Equipment>]
    def build_equipments(input)
      return [] if input.equipments.blank?

      equipments = input.equipments.reject(&:blank?)
      return [] if equipments.empty?

      equipments.uniq.map do |equipment|
        Equipment.create_or_find_by!(name: equipment)
      end
    end

    # @return [Array<RecipeStep>]
    def build_steps(input)
      return [] if input.steps.blank?

      steps = input.steps.reject(&:blank?)
      return [] if steps.empty?

      steps.map.with_index do |step, index|
        RecipeStep.new(body: step, position: index)
      end
    end
  end
end
