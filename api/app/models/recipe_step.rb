# frozen_string_literal: true

# == Schema Information
#
# Table name: recipe_steps
#
#  id         :bigint           not null, primary key
#  recipe_id  :bigint           not null
#  body       :string           not null
#  position   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_recipe_steps_on_recipe_id  (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id)
#
class RecipeStep < ApplicationRecord
  belongs_to :recipe, inverse_of: :steps

  validates :body, presence: true, length: { maximum: 1000 }
  validates :position, numericality: { greater_than_or_equal_to: 0 }
end
