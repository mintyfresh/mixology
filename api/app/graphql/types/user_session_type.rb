# frozen_string_literal: true

module Types
  class UserSessionType < BaseObject
    field :token, String, null: false
    field :expires_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
