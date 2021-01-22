# frozen_string_literal: true

module Types
  class ReviewType < BaseObject
    field :id, ID, null: false
    field :author, Types::UserType, null: false
    field :body, String, null: false
    field :rating, Integer, null: false

    def author
      Loaders::AssociationLoader.for(Review, :author).load(object)
    end
  end
end
