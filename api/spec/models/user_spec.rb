# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :citext           not null
#  email_confirmed :boolean          default(FALSE), not null
#  display_name    :citext           not null
#  date_of_birth   :date             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_display_name  (display_name) UNIQUE
#  index_users_on_email         (email) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  it 'is invalid without an email' do
    user.email = nil
    expect(user).to be_invalid
  end

  it 'is invalid when the email is invalid' do
    user.email = 'fake-email'
    expect(user).to be_invalid
  end

  it 'is invalid without a display name' do
    user.display_name = nil
    expect(user).to be_invalid
  end

  it 'is invalid when the display name is invalid' do
    user.display_name = "\0"
    expect(user).to be_invalid
  end

  it 'is invalid without a date of birth' do
    user.date_of_birth = nil
    expect(user).to be_invalid
  end
end
