# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NilClassPolicy, type: :policy do
  subject(:policy) { described_class }

  let(:user) { build(:user) }

  permissions :change_password? do
    it 'does not permit the action' do
      expect(policy).to not_permit(nil, nil)
        .and not_permit(user, nil)
    end
  end
end
