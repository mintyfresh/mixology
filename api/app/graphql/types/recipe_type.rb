# frozen_string_literal: true

module Types
  class RecipeType < BaseObject
    implements FavouriteableType

    field :id, ID, null: false
    field :author, UserType, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :ingredients, [RecipeIngredientType], null: false
    field :equipments, [RecipeEquipmentType], null: false
    field :steps, [RecipeStepType], null: false

    field :reviews, Types::ReviewType.connection_type, null: false
    field :average_rating, Float, null: true

    permissions do
      policy_permission :delete, action: :destroy?
      policy_permission :favourite
      policy_permission :review
      policy_permission :update
    end

    def author
      Loaders::AssociationLoader.for(Recipe, :author).load(object)
    end

    def ingredients
      Loaders::AssociationLoader.for(Recipe, :recipe_ingredients).load(object)
    end

    def equipments
      Loaders::AssociationLoader.for(Recipe, :recipe_equipments).load(object)
    end

    def steps
      Loaders::AssociationLoader.for(Recipe, :steps).load(object)
    end

    def reviews
      object.reviews.order(created_at: :desc, id: :desc)
    end
  end
end
