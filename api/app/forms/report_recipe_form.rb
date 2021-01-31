# frozen_string_literal: true

class ReportRecipeForm < ReportObjectForm
  attribute :recipe, Types::Instance(Recipe)

  validates :recipe, presence: true

  # @return [Report]
  def perform
    create_report!(recipe)
  end
end
