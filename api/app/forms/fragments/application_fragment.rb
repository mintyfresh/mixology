# frozen_string_literal: true

module Fragments
  class ApplicationFragment < ApplicationForm
    class << self
      undef perform
    end

    undef perform
  end
end
