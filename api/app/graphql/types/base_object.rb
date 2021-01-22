# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    class Helpers
      include ActionView::Helpers::NumberHelper
    end

    field_class Types::BaseField
    connection_type_class Types::BaseConnection
    edge_type_class Types::BaseEdge

    # @return [Helpers]
    def self.helpers
      @helpers ||= Helpers.new
    end

    # @!method helpers
    #   @return [Helpers]
    delegate :helpers, to: :class
  end
end
