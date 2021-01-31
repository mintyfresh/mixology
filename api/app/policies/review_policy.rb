# frozen_string_literal: true

class ReviewPolicy < ApplicationPolicy
  alias review record

  def show?
    !review.deleted?
  end

  def report?
    show? && current_user.present? && !author?
  end

private

  # @return [Boolean]
  def author?
    current_user.present? && current_user == review.author
  end
end
