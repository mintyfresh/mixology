# frozen_string_literal: true

# == Schema Information
#
# Table name: password_resets
#
#  id            :bigint           not null, primary key
#  user_id       :bigint
#  email         :citext           not null
#  expires_at    :datetime         not null
#  email_sent_at :datetime
#  completed_at  :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_password_resets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe PasswordReset, type: :model do
  subject(:password_reset) { build(:password_reset) }

  it 'has a valid factory' do
    expect(password_reset).to be_valid
  end

  it 'is invalid without an email' do
    password_reset.email = nil
    expect(password_reset).to be_invalid
  end

  it 'is invalid when the email is malformed' do
    password_reset.email = 'invalid-email'
    expect(password_reset).to be_invalid
  end

  it 'sets an expiry upon creation' do
    expect { password_reset.save! }.to change { password_reset.expires_at }.to be_present
  end

  it 'sets the user from the email upon creation' do
    user = create(:user)
    password_reset.user  = nil
    password_reset.email = user.email
    expect { password_reset.save! }.to change { password_reset.user }.to(user)
  end

  it 'leaves the user blank if no user has a matching email' do
    password_reset.user  = nil
    password_reset.email = Faker::Internet.email
    expect { password_reset.save! }.not_to change { password_reset.user }
  end
end
