# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewPolicy, type: :policy do
  subject(:policy) { described_class }

  let(:user) { build(:user) }
  let(:review) { build(:review) }
  let(:deleted_review) { build(:review, :deleted) }

  permissions :show? do
    it 'permits everyone' do
      expect(policy).to permit(nil, review)
        .and permit(user, review)
    end

    it 'does not permit anyone for deleted reviews' do
      expect(policy).to not_permit(nil, deleted_review)
        .and not_permit(user, deleted_review)
    end
  end

  permissions :report? do
    it 'does not permit guests' do
      expect(policy).not_to permit(nil, review)
    end

    it 'permits users' do
      expect(policy).to permit(user, review)
    end

    it 'does not permit the author' do
      expect(policy).not_to permit(review.author, review)
    end

    it 'does not permit anyone for deleted reviews' do
      expect(policy).to not_permit(nil, deleted_review)
        .and not_permit(deleted_review.author, deleted_review)
        .and not_permit(user, deleted_review)
    end
  end
end
