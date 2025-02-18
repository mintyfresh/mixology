# frozen_string_literal: true

module SoftDeletable
  extend ActiveSupport::Concern

  included do
    scope :non_deleted, -> { where(deleted_at: nil) }

    default_scope -> { non_deleted }
  end

  # @param value [Boolean]
  # @return [void]
  def deleted=(value)
    self.deleted_at = value ? Time.current : nil
  end

  # @return [Boolean]
  def deleted?
    deleted_at.present?
  end

  # @return [Boolean]
  def destroy
    update(deleted: true)
  end

  # @return [Boolean]
  def destroy!
    update!(deleted: true)
  end

  # @return [Boolean]
  def mark_for_destruction
    self.deleted = true
  end

  # @return [Boolean]
  def marked_for_destruction?
    deleted_at_changed? && deleted?
  end
end
