# frozen_string_literal: true

# == Schema Information
#
# Table name: user_credentials
#
#  id         :bigint           not null, primary key
#  type       :string           not null
#  user_id    :bigint           not null
#  data       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_credentials_on_type_and_user_id  (type,user_id) UNIQUE
#  index_user_credentials_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserPasswordCredential < UserCredential
  ARGON2_TIME_COST   = Rails.application.config.x.argon2.time_cost
  ARGON2_MEMORY_COST = Rails.application.config.x.argon2.memory_cost
  ARGON2_SECRET      = ENV['ARGON2_SECRET']

  store_accessor :data, :password_digest, :last_changed_at

  # @param password [String, nil]
  # @return [User, nil]
  def authenticate(password)
    user if password_matches_digest?(password)
  end

  # @param password [String, nil]
  # @return [void]
  def password=(password)
    self.password_digest = password && password_service.create(password)
    self.last_changed_at = Time.current.to_f
  end

  # @return [Time, nil]
  def last_changed_at
    (last_changed_at = super) && Time.zone.at(last_changed_at)
  end

private

  # @param password [String, nil]
  # @return [Boolean]
  def password_matches_digest?(password)
    return false if password.blank? || password_digest.blank?

    Argon2::Password.verify_password(password, password_digest)
  end

  # @return [Argon2::Password]
  def password_service
    Argon2::Password.new(t_cost: ARGON2_TIME_COST, m_cost: ARGON2_MEMORY_COST, secret: ARGON2_SECRET)
  end
end
