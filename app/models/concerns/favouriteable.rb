# frozen_string_literal: true

module Favouriteable
  extend ActiveSupport::Concern

  included do
    has_many :favourites, as: :favouriteable, dependent: :destroy, inverse_of: :favouriteable
  end

  # @param user [User]
  # @return [Favourite]
  def add_favourite(user)
    user.with_lock do
      favourites.find_or_create_by!(user: user)
    end
  end

  # @param user [User]
  # @return [Favourite, nil]
  def remove_favourite(user)
    user.with_lock do
      favourites.find_by(user: user)&.tap(&:destroy!)
    end
  end
end
