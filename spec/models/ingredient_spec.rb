# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id         :bigint           not null, primary key
#  name       :citext           not null
#  data       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
end
