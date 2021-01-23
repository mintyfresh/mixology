# frozen_string_literal: true

module Types
  class SignUpInputType < BaseInputObject
    argument :email, String, required: true
    argument :display_name, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true
    argument :date_of_birth, GraphQL::Types::ISO8601Date, required: true
  end
end
