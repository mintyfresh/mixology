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
    User.create!(email: email, display_name: display_name, date_of_birth: date_of_birth) do |user|
      user.credentials << UserPasswordCredential.new(password: password)
    end
  end
end
