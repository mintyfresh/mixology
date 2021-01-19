# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipePolicy, type: :policy do
  subject(:policy) { described_class }

  let(:user) { build(:user) }
  let(:recipe) { build(:recipe) }

  permissions :show? do
    it 'permits everyone to view recipes' do
      expect(policy).to permit(nil, recipe)
        .and permit(user, recipe)
    end
  end

  permissions :create? do
    it 'does not permit guests to create recipes' do
      expect(policy).not_to permit(nil, Recipe)
    end

    it 'permits users to create recipes' do
      expect(policy).to permit(user, Recipe)
    end
  end
end
