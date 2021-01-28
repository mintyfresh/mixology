# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  email         :citext           not null
#  display_name  :citext           not null
#  date_of_birth :date             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_users_on_display_name  (display_name) UNIQUE
#  index_users_on_email         (email) UNIQUE
#
class User < ApplicationRecord
  has_many :authored_recipes, class_name: 'Recipe', dependent: :destroy, foreign_key: :author_id, inverse_of: :author
  has_many :authored_reviews, class_name: 'Review', dependent: :destroy, foreign_key: :author_id, inverse_of: :author

  has_many :credentials, class_name: 'UserCredential', dependent: :delete_all, inverse_of: :user
  has_many :sessions, class_name: 'UserSession', dependent: :delete_all, inverse_of: :user

  has_many :email_confirmations, dependent: :delete_all, inverse_of: :user

  has_many :favourites, dependent: :destroy, inverse_of: :user
  has_many :favourited_recipes, through: :favourites, source: :favouriteable, source_type: 'Recipe'

  has_unique_attribute :email
  has_unique_attribute :display_name

  validates :email, email: true
  validates :display_name, display_name: true
  validates :date_of_birth, presence: true

  # @param credential_class [Class<UserCredential>]
  # @param credential [Object]
  # @return [self, nil]
  def authenticate(credential_class, credential)
    credential(credential_class)&.authenticate(credential)
  end

  # @param credential_class [Class<UserCredential>]
  # @return [UserCredential, nil]
  def credential(credential_class)
    credentials.find_by(type: credential_class.sti_name)
  end
end
