# frozen_string_literal: true

module Types
  class CreateReviewInputType < BaseInputObject
    argument :body, String, required: true
    argument :rating, Integer, required: true
  end
end
