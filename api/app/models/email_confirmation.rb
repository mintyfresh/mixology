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
class EmailConfirmation < ApplicationRecord
  LIFETIME = 30.days

  belongs_to :user, inverse_of: :email_confirmations

  validates :email, email: true

  before_create :set_expiry, if: -> { expires_at.nil? }

  # @param token [String, nil]
  # @return [EmailConfirmation, nil]
  def self.find_by_token(token)
    GlobalID::Locator.locate_signed(token, only: self) if token.present?
  rescue ActiveRecord::RecordNotFound
    nil
  end

  # @return [Boolean]
  def confirm!
    with_lock do
      return true if confirmed?

      update!(confirmed_at: Time.current)
    end
  end

  # @return [Boolean]
  def confirmed?
    confirmed_at.present?
  end

  # @return [Boolean]
  def expired?
    expires_at.present? && expires_at.past?
  end

  # @return [Boolean]
  def stale?
    user.email != email
  end

  # @return [String]
  def token
    @token ||= to_sgid.to_s.freeze
  end

private

  # @return [void]
  def set_expiry
    self.expires_at = Time.current + LIFETIME
  end
end
