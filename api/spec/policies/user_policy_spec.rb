# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject(:policy) { described_class }

  let(:user) { build(:user) }
  let(:other_user) { build(:user) }

  permissions :change_password? do
    it "does not permit guests to change a user's password" do
      expect(policy).not_to permit(nil, user)
    end

    it 'permits a user to change their own password' do
      expect(policy).to permit(user, user)
    end

    it "does not allow users to change other users' passwords" do
      expect(policy).to not_permit(user, other_user)
        .and not_permit(other_user, user)
    end
  end
end
