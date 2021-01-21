# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id         :bigint           not null, primary key
#  name       :citext           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ingredients_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  subject(:ingredient) { build(:ingredient) }

  it 'has a valid factory' do
    expect(ingredient).to be_valid
  end

  it 'is invalid without a name' do
    ingredient.name = nil
    expect(ingredient).to be_invalid
  end

  it 'is invalid when the name is longer than 100 characters' do
    ingredient.name = 'a' * 101
    expect(ingredient).to be_invalid
  end
end
