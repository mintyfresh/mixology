# frozen_string_literal: true

module Types
  class RecipeType < BaseObject
    implements FavouriteableType

    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :ingredients, [RecipeIngredientType], null: false
    field :equipments, [RecipeEquipmentType], null: false
    field :steps, [RecipeStepType], null: false
    field :author, UserType, null: false

    def ingredients
      Loaders::AssociationLoader.for(Recipe, :recipe_ingredients).load(object)
    end

    def equipments
      Loaders::AssociationLoader.for(Recipe, :recipe_equipments).load(object)
    end

    def steps
      Loaders::AssociationLoader.for(Recipe, :steps).load(object)
    end

    def author
      Loaders::AssociationLoader.for(Recipe, :author).load(object)
    end
  end
end
