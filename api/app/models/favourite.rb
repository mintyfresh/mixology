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
class Favourite < ApplicationRecord
  belongs_to :user, inverse_of: :favourites
  belongs_to :favouriteable, counter_cache: true, polymorphic: true, inverse_of: :favourites
end
