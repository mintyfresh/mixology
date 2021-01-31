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

  describe '.perform' do
    subject(:perform) { described_class.perform(input) }

    let(:email_confirmation) { create(:email_confirmation) }

    it 'returns confirmed' do
      expect(perform).to eq(ConfirmEmailResult::CONFIRMED)
    end

    it 'marks the email confirmation as completed' do
      expect { perform }.to change { email_confirmation.completed? }.to(true)
    end

    it 'marks the user as having their email confirmed' do
      expect { perform }.to change { email_confirmation.user.email_confirmed? }.to(true)
    end

    context 'when the email confirmation is already completed' do
      let(:email_confirmation) { create(:email_confirmation, :completed) }

      it 'returns confirmed' do
        expect(perform).to eq(ConfirmEmailResult::CONFIRMED)
      end

      it "doesn't mark the user as having their email confirmed" do
        expect { perform }.not_to change { email_confirmation.user.email_confirmed? }
      end
    end

    context 'when the email confirmation is expired' do
      let(:email_confirmation) { create(:email_confirmation, :expired) }

      it 'returns expired' do
        expect(perform).to eq(ConfirmEmailResult::EXPIRED)
      end

      it "doesn't mark the email confirmation as confirmed" do
        expect { perform }.not_to change { email_confirmation.completed? }
      end

      it "doesn't mark the user as having their email confirmed" do
        expect { perform }.not_to change { email_confirmation.user.email_confirmed? }
      end
    end

    context 'when the email confirmation is stale' do
      let(:email_confirmation) { create(:email_confirmation, :stale) }

      it 'returns stale' do
        expect(perform).to eq(ConfirmEmailResult::STALE)
      end

      it "doesn't mark the email confirmation as confirmed" do
        expect { perform }.not_to change { email_confirmation.completed? }
      end

      it "doesn't mark the user as having their email confirmed" do
        expect { perform }.not_to change { email_confirmation.user.email_confirmed? }
      end
    end
  end
end
