# frozen_string_literal: true

module Types
  module FavouriteableType
    include BaseInterface

    field :favourites_count, Integer, null: false
    field :is_favourite, Boolean, null: false, resolver_method: :favourite?

    def favourite?
      return false if current_user.nil?

      scope = Favourite.where(user: current_user, favouriteable_type: object.polymorphic_name)

      Loaders::ExistenceLoader.for(Favourite, :favouriteable_id, scope: scope).load(object.id)
    end
  end
end
