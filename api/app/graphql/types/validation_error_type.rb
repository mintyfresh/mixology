# frozen_string_literal: true

module Types
  class ValidationErrorType < BaseObject
    field :attribute, String, null: false
    field :message, String, null: false do
      argument :include_name, Boolean, required: false, default_value: false
    end

    # @return [String]
    def attribute
      object.attribute.to_s.camelcase(:lower)
    end

    # @param include_name [Boolean]
    # @return [String]
    def message(include_name: false)
      include_name ? object.full_message : object.message
    end
  end
end
