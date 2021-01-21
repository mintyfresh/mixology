# frozen_string_literal: true

module Types
  class BaseEdge < GraphQL::Types::Relay::BaseEdge
    def self.node_type(*args, null: false, **options)
      super(*args, **options, null: null)
    end
  end
end
