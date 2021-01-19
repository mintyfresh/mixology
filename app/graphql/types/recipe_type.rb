# frozen_string_literal: true

module Types
  class RecipeType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :ingredients, [String], null: false
    field :equipments, [String], null: false
    field :steps, [String], null: false
    field :author, Types::UserType, null: false

    def ingredients
      Loaders::AssociationLoader.for(Recipe, :ingredients).load(object).then do |ingredients|
        ingredients.map(&:name)
      end
    end

    def equipments
      Loaders::AssociationLoader.for(Recipe, :equipments).load(object).then do |equipments|
        equipments.map(&:name)
      end
    end

    def steps
      Loaders::AssociationLoader.for(Recipe, :steps).load(object).then do |steps|
        steps.map(&:body)
      end
    end

    def author
      Loaders::AssociationLoader.for(Recipe, :author).load(object)
    end
  end
end
