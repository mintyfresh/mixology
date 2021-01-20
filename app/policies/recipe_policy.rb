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

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
