# frozen_string_literal: true

class SignInForm < ApplicationForm
  attribute :email, Types::String
  attribute :password, Types::String

  validates :email, email: true
  validates :password, presence: true

  def perform
    user = User.find_by(email: email)
    return errors.add(:base, :incorrect_credentials) if user.nil?

    user = user.authenticate(UserPasswordCredential, password)
    return errors.add(:base, :incorrect_credentials) if user.nil?

    user
  end
end
