# frozen_string_literal: true

module Reportable
  extend ActiveSupport::Concern

  included do
    has_many :reports, as: :reportable, dependent: :destroy, inverse_of: :reportable
  end
end
