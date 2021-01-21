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
require 'rails_helper'

RSpec.describe RecipeStep, type: :model do
  subject(:recipe_step) { build(:recipe_step) }

  it 'has a valid factory' do
    expect(recipe_step).to be_valid
  end

  it 'is invalid without a body' do
    recipe_step.body = nil
    expect(recipe_step).to be_invalid
  end

  it 'is invalid when the body is longer than 1000 characters' do
    recipe_step.body = 'a' * 1001
    expect(recipe_step).to be_invalid
  end

  it 'is invalid without a position' do
    recipe_step.position = nil
    expect(recipe_step).to be_invalid
  end

  it 'is invalid when the position is negative' do
    recipe_step.position = -1
    expect(recipe_step).to be_invalid
  end
end
