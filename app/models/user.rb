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
  validates :email, email: true
  validates :display_name, display_name: true
  validates :date_of_birth, presence: true
end
