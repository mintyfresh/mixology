# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportReviewForm, type: :form do
  subject(:form) { described_class.new(**input, author: author, review: review) }

  let(:input) { attributes_for(:create_report_input) }
  let(:author) { create(:user) }
  let(:review) { create(:review) }

  it 'has a valid input factory' do
    expect(form).to be_valid
  end

  it 'is invalid without a message' do
    input[:message] = nil
    expect(form).to be_invalid
  end

  it 'is invalid when the message is too long' do
    input[:message] = 'a' * (Report::MESSAGE_MAX_LENGTH + 1)
    expect(form).to be_invalid
  end

  describe '.perform' do
    subject(:perform) { described_class.perform(**input, author: author, review: review) }

    it 'creates and returns a new report' do
      expect(perform).to be_a(Report)
        .and be_persisted
        .and have_attributes(message: input[:message])
    end

    it 'is associated to the author that submitted it' do
      expect(perform.author).to eq(author)
    end

    it 'is associated to the review that it refers to' do
      expect(perform.reportable).to eq(review)
    end
  end
end
