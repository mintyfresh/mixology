# frozen_string_literal: true

class SignUpForm < ApplicationForm
  attribute :email, Types::StrippedString
  attribute :display_name, Types::StrippedString
  attribute :password, Types::String
  attribute :password_confirmation, Types::String
  attribute :date_of_birth, Types::Date

  validates :email, email: true
  validates :display_name, display_name: true
  validates :password, confirmation: true, password: true
  validates :password_confirmation, presence: true
  validates :date_of_birth, presence: true

  # @return [User]
  def perform
    user = User.new(email: email, display_name: display_name, date_of_birth: date_of_birth)

    user.credentials << UserPasswordCredential.new(password: password)
    user.email_confirmations << EmailConfirmation.new(email: user.email)
    user.save!

    # TODO: Replace with pub/sub mechanism.
    # Publish an event that the user has signed up and trigger the email elsewhere.
    send_email_confirmation(user)

    user
  end

private

  # @param user [User]
  # @return [void]
  def send_email_confirmation(user)
    EmailConfirmationMailer.with(email_confirmation: user.email_confirmations.last).email_confirmation.deliver_later
  end
end
