# frozen_string_literal: true

class ReportReviewForm < ReportObjectForm
  attribute :review, Types::Instance(Review)

  validates :review, presence: true

  # @return [Report]
  def perform
    create_report!(review)
  end
end
