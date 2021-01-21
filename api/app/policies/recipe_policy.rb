# frozen_string_literal: true

class RecipePolicy < ApplicationPolicy
  alias recipe record

  def show?
    !recipe.deleted?
  end

  def create?
    current_user.present?
  end

  def favourite?
    show? && current_user.present?
  end

  def destroy?
    show? && author?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

private

  # @return [Boolean]
  def author?
    current_user.present? && current_user == recipe.author
  end
end
