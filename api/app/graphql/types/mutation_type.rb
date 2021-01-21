# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_recipe, mutation: Mutations::CreateRecipeMutation
    field :add_favourite_recipe, mutation: Mutations::AddFavouriteRecipeMutation
    field :remove_favourite_recipe, mutation: Mutations::RemoveFavouriteRecipeMutation
    field :delete_recipe, mutation: Mutations::DeleteRecipeMutation
  end
end
