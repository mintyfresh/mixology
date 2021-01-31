# frozen_string_literal: true

module Types
  class ConfirmEmailResultType < BaseEnum
    include ConfirmEmailResult

    value 'CONFIRMED', value: CONFIRMED
    value 'EXPIRED',   value: EXPIRED
    value 'STALE',     value: STALE
  end
end
