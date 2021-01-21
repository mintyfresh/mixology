# frozen_string_literal: true

class ApplicationPolicy
  # @return [User, nil]
  attr_reader :current_user
  # @return [Object]
  attr_reader :record

  # @param current_user [User, nil]
  # @param record [Object]
  def initialize(current_user, record)
    @current_user = current_user
    @record       = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    # @return [User, nil]
    attr_reader :current_user
    # @return [ActiveRecord::Relation]
    attr_reader :scope

    # @param current_user [User, nil]
    # @param scope [ActiveRecord::Relation]
    def initialize(current_user, scope)
      @current_user = current_user
      @scope        = scope
    end

    def resolve
      scope.all
    end
  end
end
