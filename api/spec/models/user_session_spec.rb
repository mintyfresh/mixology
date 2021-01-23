# frozen_string_literal: true

# == Schema Information
#
# Table name: user_sessions
#
#  id                  :bigint           not null, primary key
#  user_id             :bigint           not null
#  expires_at          :datetime         not null
#  revoked_at          :datetime
#  creation_ip         :inet
#  creation_user_agent :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_user_sessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserSession, type: :model do
  subject(:user_session) { build(:user_session) }

  it 'has a valid factory' do
    expect(user_session).to be_valid
  end

  it 'is invalid without a user' do
    user_session.user = nil
    expect(user_session).to be_invalid
  end

  it 'sets an expiry upon creation' do
    expect { user_session.save! }.to change { user_session.expires_at }.to be_future
  end

  describe '.find_by_token' do
    subject(:find_by_token) { described_class.find_by_token(token) }

    let(:token) { user_session.token }
    let(:user_session) { create(:user_session) }

    it 'returns the matching user session' do
      expect(find_by_token).to eq(user_session)
    end

    context 'when the session is expired' do
      let(:user_session) { create(:user_session, :expired) }

      it 'returns nil' do
        expect(find_by_token).to be_nil
      end
    end

    context 'when the session is revoked' do
      let(:user_session) { create(:user_session, :revoked) }

      it 'returns nil' do
        expect(find_by_token).to be_nil
      end
    end

    context 'when the token is invalid' do
      let(:token) { 'invalid-token' }

      it 'returns nil' do
        expect(find_by_token).to be_nil
      end
    end

    context 'when the token is issued for a different type of record' do
      let(:token) { user.to_sgid.to_s }
      let(:user) { create(:user) }

      it 'returns nil' do
        expect(find_by_token).to be_nil
      end
    end
  end
end
