# frozen_string_literal: true

module Queries
  class PasswordResetQuery < BaseQuery
    type Types::PasswordResetType, null: false

    argument :token, String, required: true

    def resolve(token:)
      PasswordReset.find_by_token(token) ||
        raise(ActiveRecord::RecordNotFound.new(nil, PasswordReset))
    end
  end
end
