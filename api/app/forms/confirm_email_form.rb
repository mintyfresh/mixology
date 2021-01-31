# frozen_string_literal: true

class ConfirmEmailForm < ApplicationForm
  include ConfirmEmailResult

  attribute :email_confirmation, Types::Instance(EmailConfirmation)

  validates :email_confirmation, presence: { message: :not_found }

  # @return [EmailConfirmation]
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
end
