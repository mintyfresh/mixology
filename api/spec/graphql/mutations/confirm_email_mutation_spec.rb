# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::ConfirmEmailMutation, type: :graphql_mutation do
  subject(:mutation) { described_class.new(object: nil, field: nil, context: context) }

  let(:context) { build(:graphql_context, :guest) }

  describe '#resolve' do
    subject(:resolve) { mutation.resolve(token: token) }

    let(:token) { email_confirmation.token }
    let(:user) { email_confirmation.user }
    let(:email_confirmation) { create(:email_confirmation) }

    it 'returns success' do
      expect(resolve[:success]).to be(true)
    end

    it 'marks the email confirmation as completed' do
      expect { resolve }.to change { email_confirmation.reload.completed? }.to(true)
    end

    it "marks the user's email as confirmed" do
      expect { resolve }.to change { user.reload.email_confirmed? }.to(true)
    end

    context 'when the token is invalid' do
      let(:token) { 'fake-token' }

      it 'returns a list of errors' do
        expect(resolve[:errors]).to be_present
      end

      it 'does not complete the email confirmation process' do
        expect { resolve }.to not_change { email_confirmation.reload.completed? }
          .and not_change { user.reload.email_confirmed? }
      end
    end

    context 'when the email confirmation is not active' do
      let(:email_confirmation) { create(:email_confirmation, :expired) }

      it 'returns a list of errors' do
        expect(resolve[:errors]).to be_present
      end

      it 'does not complete the email confirmation process' do
        expect { resolve }.to not_change { email_confirmation.reload.completed? }
          .and not_change { user.reload.email_confirmed? }
      end
    end
  end
end
