# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator
  EMAIL_FORMAT = URI::MailTo::EMAIL_REGEXP

  # @param record [ApplicationRecord, ApplicationForm]
  # @param attribute [Symbol]
  # @param value [String, nil]
  # @return [void]
  def validate_each(record, attribute, value)
    return if value.blank? && options[:allow_blank]
    return if EMAIL_FORMAT.match?(value)

    record.errors.add(attribute, options.fetch(:message, :email))
  end
end
