# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordResetPolicy, type: :policy do
  subject(:policy) { described_class }

  let(:user) { build(:user) }

  permissions :request? do
    it 'permits guests to request a password reset' do
      expect(policy).to permit(nil, PasswordReset)
    end

    it 'does not permit authenticated users to request a password reset' do
      expect(policy).not_to permit(user, PasswordReset)
    end
  end
end
