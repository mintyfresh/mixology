# frozen_string_literal: true

class ReportObjectForm < ApplicationForm
  attribute :author, Types::Instance(User)
  attribute :message, Types::StrippedString

  validates :author, :message, presence: true
  validates :message, length: { maximum: Report::MESSAGE_MAX_LENGTH }

protected

  # @param reportable [#reports]
  # @return [Report]
  def create_report!(reportable)
    reportable.reports.create!(author: author, message: message)
  end
end
