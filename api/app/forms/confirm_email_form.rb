# frozen_string_literal: true

class ConfirmEmailForm < ApplicationForm
  include ConfirmEmailResult

  attribute :email_confirmation, Types::Instance(EmailConfirmation)

  validate :email_confirmation_exists

  # @return [Symbol]
  def perform
    email_confirmation.with_lock do
      return CONFIRMED if email_confirmation.completed?
      return EXPIRED   if email_confirmation.expired?
      return STALE     if email_confirmation.stale?

      email_confirmation.completed!
      email_confirmation.user.update!(email_confirmed: true)
    end

    CONFIRMED
  end

private

  # @return [void]
  def email_confirmation_exists
    errors.add(:base, :not_found) if email_confirmation.nil?
  end
end
