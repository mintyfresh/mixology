# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :current_user, resolver: Queries::CurrentUserQuery
  end
end
