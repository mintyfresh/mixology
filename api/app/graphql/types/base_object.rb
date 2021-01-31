# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    class Helpers
      include ActionView::Helpers::NumberHelper
    end

    include Authorization

    field_class Types::BaseField
    connection_type_class Types::BaseConnection
    edge_type_class Types::BaseEdge

    # @return [void]
    def self.permissions(&block)
      klass = Class.new(BasePermissions)
      const_set('Permissions', klass)

      klass.graphql_name("#{graphql_name}Permissions")
      klass.description("Permissions granted to the current user for this #{graphql_name}.")
      klass.instance_eval(&block)

      field(:permissions, klass, null: false, resolver_method: :object)
    end

    # @return [Helpers]
    def self.helpers
      @helpers ||= Helpers.new
    end

    # @!method helpers
    #   @return [Helpers]
    delegate :helpers, to: :class
  end
end
