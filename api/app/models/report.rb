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
class Report < ApplicationRecord
  MESSAGE_MAX_LENGTH = 1000

  belongs_to :author, class_name: 'User', inverse_of: :authored_reports
  belongs_to :reportable, inverse_of: :reports, polymorphic: true

  validates :message, presence: true, length: { maximum: MESSAGE_MAX_LENGTH }
end
