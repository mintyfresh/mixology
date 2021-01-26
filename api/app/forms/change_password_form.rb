# frozen_string_literal: true

class ChangePasswordForm < ApplicationForm
  attribute :user, Types::Instance(User)
  attribute :old_password, Types::String
  attribute :new_password, Types::String
  attribute :new_password_confirmation, Types::String

  validates :user, :old_password, presence: true
  validates :new_password, confirmation: true, password: true
  validates :new_password_confirmation, presence: true

  # @return [User]
  def perform
    user = self.user.authenticate(UserPasswordCredential, old_password)
    return errors.add(:base, :incorrect_credentials) if user.nil?

    user.credential(UserPasswordCredential).update!(password: new_password)

    user
  end
end
