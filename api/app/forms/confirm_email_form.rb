# frozen_string_literal: true

class ConfirmEmailForm < ApplicationForm
  attribute :email_confirmation, Types::Instance(EmailConfirmation)

  validates :email_confirmation, presence: { message: :not_found }
  validate  :email_confirmation_is_active, if: -> { email_confirmation }

  # @return [EmailConfirmation]
  def perform
    transaction do
      email_confirmation.completed!
      email_confirmation.user.update!(email_confirmed: true)
    end

    email_confirmation
  end

private

  # @return [void]
  def email_confirmation_is_active
    return errors.add(:base, :completed) if email_confirmation.completed?
    return errors.add(:base, :expired)   if email_confirmation.expired?
    return errors.add(:base, :stale)     if email_confirmation.stale?
  end
end
