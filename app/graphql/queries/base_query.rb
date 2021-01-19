# frozen_string_literal: true

module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    include Authorization

    argument_class Types::BaseArgument
  end
end
