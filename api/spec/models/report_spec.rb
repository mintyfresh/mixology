# frozen_string_literal: true

# == Schema Information
#
# Table name: reports
#
#  id              :bigint           not null, primary key
#  author_id       :bigint           not null
#  reportable_type :string           not null
#  reportable_id   :bigint           not null
#  message         :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_reports_on_author_id   (author_id)
#  index_reports_on_reportable  (reportable_type,reportable_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#
require 'rails_helper'

RSpec.describe Report, type: :model do
  subject(:report) { build(:report) }

  it 'has a valid factory' do
    expect(report).to be_valid
  end

  it 'is invalid without an author' do
    report.author = nil
    expect(report).to be_invalid
  end

  it 'is invalid without a reportable object' do
    report.reportable = nil
    expect(report).to be_invalid
  end

  it 'is invalid without a message' do
    report.message = nil
    expect(report).to be_invalid
  end

  it 'is invalid when the message is too long' do
    report.message = 'a' * (described_class::MESSAGE_MAX_LENGTH + 1)
    expect(report).to be_invalid
  end
end
