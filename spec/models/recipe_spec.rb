# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id          :bigint           not null, primary key
#  author_id   :bigint           not null
#  name        :string           not null
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_recipes_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#
require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject(:recipe) { build(:recipe) }

  it 'has a valid factory' do
    expect(recipe).to be_valid
  end

  it 'is invalid without an author' do
    recipe.author = nil
    expect(recipe).to be_invalid
  end

  it 'is invalid without a name' do
    recipe.name = nil
    expect(recipe).to be_invalid
  end

  it 'is invalid when the name is too long' do
    recipe.name = 'a' * 101
    expect(recipe).to be_invalid
  end

  it 'is valid without a description' do
    recipe.description = nil
    expect(recipe).to be_valid
  end

  it 'is invalid when the description is too long' do
    recipe.description = 'a' * 2501
    expect(recipe).to be_invalid
  end
end
