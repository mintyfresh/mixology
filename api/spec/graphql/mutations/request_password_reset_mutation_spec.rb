# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::RequestPasswordResetMutation, type: :graphql_mutation do
  subject(:mutation) { described_class.new(object: nil, field: nil, context: context) }

  let(:context) { build(:graphql_context, :guest) }

  describe '#resolve' do
    subject(:resolve) { mutation.resolve(email: email) }

    let(:email) { user.email }
    let(:user) { create(:user) }

    it 'returns success' do
      expect(resolve[:success]).to be(true)
    end

    it 'sends a password reset email to the specified email' do
      expect { resolve }.to have_enqueued_mail(PasswordResetMailer, :request_password_reset)
        .with { |params:, **| params[:password_reset].email == email }
    end

    context 'when a user is signed in' do
      let(:context) { build(:graphql_context) }

      it 'raises a Pundit::NotAuthorizedError' do
        expect { resolve }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when the email does not have a matching user' do
      let(:email) { Faker::Internet.email }

      it 'returns success' do
        expect(resolve[:success]).to be(true)
      end

      it 'does not send a password reset email' do
        expect { resolve }.not_to have_enqueued_mail(PasswordResetMailer, :request_password_reset)
      end
    end
  end
end
