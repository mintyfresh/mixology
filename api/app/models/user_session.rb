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
class UserSession < ApplicationRecord
  LIFETIME = 3.months

  belongs_to :user, inverse_of: :sessions

  before_create :set_expires_at, if: -> { expires_at.nil? }

  # @param token [String, nil]
  # @return [UserSession, nil]
  def self.find_by_token(token)
    return if token.blank?

    session = GlobalID::Locator.locate_signed(token, only: [self])
    return if session.nil? || session.expired? || session.revoked?

    session
  end

  # @return [Boolean]
  def expired?
    expires_at.past?
  end

  # @return [Boolean]
  def revoked?
    revoked_at.present?
  end

  # @return [Boolean]
  def revoke!
    with_lock do
      return true if revoked?

      update!(revoked_at: Time.current)
    end
  end

  # @return [String]
  def token
    to_sgid.to_s
  end

private

  # @return [void]
  def set_expires_at
    self.expires_at = Time.current + LIFETIME
  end
end
