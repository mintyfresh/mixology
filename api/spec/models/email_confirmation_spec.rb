# frozen_string_literal: true

# == Schema Information
#
# Table name: email_confirmations
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  email        :citext           not null
#  expires_at   :datetime         not null
#  confirmed_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_email_confirmations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe EmailConfirmation, type: :model do
  subject(:email_confirmation) { build(:email_confirmation) }

  it 'has a valid factory' do
    expect(email_confirmation).to be_valid
  end

  it 'is invalid without a user' do
    email_confirmation.user = nil
    expect(email_confirmation).to be_invalid
  end

  it 'is invalid without an email' do
    email_confirmation.email = nil
    expect(email_confirmation).to be_invalid
  end

  it 'is invalid when the email is malformed' do
    email_confirmation.email = 'invalid-email'
    expect(email_confirmation).to be_invalid
  end

  it 'sets an expiry when created' do
    expect { email_confirmation.save! }.to change { email_confirmation.expires_at }.to be_present
  end
end
