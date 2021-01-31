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
class PasswordReset < ApplicationRecord
  LIFETIME = 30.minutes

  belongs_to :user, inverse_of: :password_resets, optional: true

  validates :email, email: true

  before_create :set_expiry, if: -> { expires_at.nil? }
  before_create :set_user_from_email, if: -> { user.nil? }

  # @param token [String, nil]
  # @return [PasswordReset, nil]
  def self.find_by_token(token)
    GlobalID::Locator.locate_signed(token, only: self) if token.present?
  rescue ActiveRecord::RecordNotFound
    nil
  end

  # @return [void]
  def expired?
    expires_at.past?
  end

  # @return [Boolean]
  def email_sent?
    email_sent_at.present?
  end

  # @return [Boolean]
  def email_sent!
    update!(email_sent_at: Time.current)
  end

  # @return [Boolean]
  def completed?
    completed_at.present?
  end

  # @return [Boolean]
  def completed!
    update!(completed_at: Time.current)
  end

  # @return [String]
  def token
    @token ||= to_sgid.to_s
  end

private

  # @return [void]
  def set_expiry
    self.expires_at = Time.current + LIFETIME
  end

  # @return [void]
  def set_user_from_email
    self.user = User.find_by(email: email)
  end
end
