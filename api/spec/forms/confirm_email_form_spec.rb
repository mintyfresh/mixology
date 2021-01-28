# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConfirmEmailForm, type: :form do
  subject(:form) { described_class.new(input) }

  let(:input) { { email_confirmation: email_confirmation } }
  let(:email_confirmation) { build(:email_confirmation) }

  it 'has a valid input factory' do
    expect(form).to be_valid
  end

  it 'is invalid without an email confirmation' do
    input[:email_confirmation] = nil
    expect(form).to be_invalid
  end

  it 'is invalid when the email has already been completed' do
    input[:email_confirmation] = build(:email_confirmation, :completed)
    expect(form).to be_invalid
  end

  it 'is invalid when the email confirmation is expired' do
    input[:email_confirmation] = build(:email_confirmation, :expired)
    expect(form).to be_invalid
  end

  it 'is invalid when the email confirmation is stale' do
    input[:email_confirmation] = build(:email_confirmation, :stale)
    expect(form).to be_invalid
  end

  describe '.perform' do
    subject(:perform) { described_class.perform(input) }

    let(:email_confirmation) { create(:email_confirmation) }

    it 'returns the email confirmation' do
      expect(perform).to eq(email_confirmation)
    end

    it 'marks the email confirmation as completed' do
      expect { perform }.to change { email_confirmation.completed? }.to(true)
    end

    it 'marks the user as having their email confirmed' do
      expect { perform }.to change { email_confirmation.user.email_confirmed? }.to(true)
    end
  end
end
