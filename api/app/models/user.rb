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

  has_many :favourites, dependent: :destroy, inverse_of: :user
  has_many :favourited_recipes, through: :favourites, source: :favouriteable, source_type: 'Recipe'

  validates :email, email: true
  validates :display_name, display_name: true
  validates :date_of_birth, presence: true
end
