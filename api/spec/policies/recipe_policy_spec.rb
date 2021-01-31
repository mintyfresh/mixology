# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipePolicy, type: :policy do
  subject(:policy) { described_class }

  let(:user) { build(:user) }
  let(:recipe) { build(:recipe) }
  let(:deleted_recipe) { build(:recipe, :deleted) }

  permissions :show? do
    it 'permits everyone to view recipes' do
      expect(policy).to permit(nil, recipe)
        .and permit(user, recipe)
    end

    it 'does not permit anyone to view deleted recipes' do
      expect(policy).to not_permit(nil, deleted_recipe)
        .and not_permit(user, deleted_recipe)
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

  permissions :favourite? do
    it 'does not permit guests to favourite recipes' do
      expect(policy).not_to permit(nil, recipe)
    end

    it 'permits users to favourite recipes' do
      expect(policy).to permit(user, recipe)
    end

    it 'does not permit anyone to favourite deleted recipes' do
      expect(policy).to not_permit(nil, deleted_recipe)
        .and not_permit(user, deleted_recipe)
    end
  end

  permissions :update?, :destroy? do
    it 'does not permit guests to modify recipes' do
      expect(policy).not_to permit(nil, recipe)
    end

    it 'permits recipe authors to modify their own recipes' do
      expect(policy).to permit(recipe.author, recipe)
    end

    it "does not permit users to modify recipes they don't own" do
      expect(policy).not_to permit(user, recipe)
    end

    it 'does not permit anyone to modify deleted recipes' do
      expect(policy).to not_permit(nil, deleted_recipe)
        .and not_permit(deleted_recipe.author, deleted_recipe)
        .and not_permit(user, deleted_recipe)
    end
  end
end
