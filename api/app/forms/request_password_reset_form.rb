# frozen_string_literal: true

class RequestPasswordResetForm < ApplicationForm
  attribute :email, Types::StrippedString

  validates :email, email: true

  # @return [PasswordReset]
  def perform
    PasswordReset.create!(email: email)
  end
end
