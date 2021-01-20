# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddFavouriteRecipeForm, type: :form do
  subject(:form) { described_class.new(input) }

  let(:input) { { user: user, recipe: recipe } }
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe) }

  it 'has a valid input' do
    expect(form).to be_valid
  end

  it 'is invalid without a user' do
    input[:user] = nil
    expect(form).to be_invalid
  end

  it 'is invalid without a recipe' do
    input[:recipe] = nil
    expect(form).to be_invalid
  end

  it 'is invalid when the user is the author of the recipe' do
    input[:user] = recipe.author
    expect(form).to be_invalid
  end

  describe '.perform' do
    subject(:perform) { described_class.perform(input) }

    it "adds the recipe to the user's favourites" do
      perform
      expect(recipe).to be_favourited_by(user)
    end

    context "when the recipe is already in the user's favourites" do
      before(:each) do
        recipe.add_favourite(user)
      end

      it 'does nothing' do
        expect { perform }.not_to change { recipe.favourite_ids }
      end
    end
  end
end
