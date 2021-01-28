# frozen_string_literal: true

class ConfirmEmailForm < ApplicationForm
  attribute :email_confirmation, Types::Instance(EmailConfirmation), optional: false

  validate :email_confirmation_is_active

  # @return [EmailConfirmation]
  def perform
    transaction do
      email_confirmation.confirm!
      email_confirmation.user.update!(email_confirmed: true)
    end

    email_confirmation
  end

private

  # @return [void]
  def email_confirmation_is_active
    return errors.add(:base, :confirmed) if email_confirmation.confirmed?
    return errors.add(:base, :expired)   if email_confirmation.expired?
    return errors.add(:base, :stale)     if email_confirmation.stale?
  end
end
