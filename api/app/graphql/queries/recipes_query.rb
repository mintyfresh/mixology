# frozen_string_literal: true

module Queries
  class RecipesQuery < BaseQuery
    class SortingType < Types::BaseEnum
      value 'DEFAULT', value:       -> (scope) { scope }
      value 'LATEST', value:        -> (scope) { scope.order(created_at: :desc) }
      value 'MOST_POPULAR', value:  -> (scope) { scope.order(favourites_count: :desc) }
      value 'HIGHEST_RATED', value: -> (scope) { scope.order(average_rating: :desc) }

      # @return [Proc]
      def self.default_value
        @default_value ||= values['DEFAULT'].value
      end
    end

    type Types::RecipeType.connection_type, null: false

    argument :sorting, SortingType, required: false, default_value: SortingType.default_value

    def resolve(sorting: SortingType.default_value)
      recipes = policy_scope(Recipe.all)
      recipes = sorting.call(recipes)

      recipes.order(:id)
    end
  end
end
