# frozen_string_literal: true

# == Schema Information
#
# Table name: favourites
#
#  id                 :bigint           not null, primary key
#  user_id            :bigint           not null
#  favouriteable_type :string           not null
#  favouriteable_id   :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_favourites_on_favouriteable           (favouriteable_type,favouriteable_id)
#  index_favourites_on_user_and_favouriteable  (user_id,favouriteable_type,favouriteable_id) UNIQUE
#  index_favourites_on_user_id                 (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Favourite, type: :model do
  subject(:favourite) { build(:favourite) }

  it 'has a valid factory' do
    expect(favourite).to be_valid
  end

  it 'is invalid without a user' do
    favourite.user = nil
    expect(favourite).to be_invalid
  end

  it 'is invalid without a favouriteable object' do
    favourite.favouriteable = nil
    expect(favourite).to be_invalid
  end
end
