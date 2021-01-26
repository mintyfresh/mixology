# frozen_string_literal: true

class ChangePasswordForm < ApplicationForm
  attribute :user, Types::Instance(User)
  attribute :old_password, Types::String
  attribute :new_password, Types::String
  attribute :new_password_confirmation, Types::String

  validates :user, :old_password, presence: true
  validates :new_password, confirmation: true, password: true
  validates :new_password_confirmation, presence: true
  validate  :old_password_matches_user, if: -> { user && old_password.present? }

  # @return [User]
  def perform
    user.credential(UserPasswordCredential).update!(password: new_password)

    user
  end

private

  # @return [void]
  def old_password_matches_user
    return if user.authenticate(UserPasswordCredential, old_password)

    errors.add(:old_password, :incorrect)
  end
end
