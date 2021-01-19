# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :current_user, resolver: Queries::CurrentUserQuery

    field :recipes, resolver: Queries::RecipesQuery
    field :recipe, resolver: Queries::RecipeQuery
  end
end
