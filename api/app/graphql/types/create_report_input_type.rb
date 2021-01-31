# frozen_string_literal: true

module Types
  class CreateReportInputType < BaseInputObject
    argument :message, String, required: true
  end
end
