# frozen_string_literal: true

module Types
  class RecipeStepType < BaseObject
    field :id, ID, null: false
    field :body, String, null: false
  end
end
