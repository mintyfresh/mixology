# frozen_string_literal: true

# == Schema Information
#
# Table name: equipment
#
#  id         :bigint           not null, primary key
#  name       :citext           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_equipment_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Equipment, type: :model do
  subject(:equipment) { build(:equipment) }

  it 'has a valid factory' do
    expect(equipment).to be_valid
  end

  it 'is invalid without a name' do
    equipment.name = nil
    expect(equipment).to be_invalid
  end

  it 'is invalid when the name is longer than 100 characters' do
    equipment.name = 'a' * 101
    expect(equipment).to be_invalid
  end
end
