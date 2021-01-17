# frozen_string_literal: true

module Queries
  class CurrentUserQuery < BaseQuery
    type Types::UserType, null: true

    def resolve
      current_user
    end
  end
end
