# frozen_string_literal: true

module Authorization
  include GraphQLContext

  # @param record [Class, Object]
  # @return [ApplicationPolicy]
  def policy(record)
    Pundit.policy!(current_user, record)
  end

  # @param relation [ActiveRecord::Relation]
  # @return [ActiveRecord::Relation]
  def policy_scope(relation)
    Pundit.policy_scope!(current_user, relation)
  end

  # @param record [Class, Object]
  # @param action [Symbol, String]
  # @return [Boolean]
  def permitted?(record, action)
    policy(record).public_send(action)
  end

  # @param record [Class, Object]
  # @param action [Symbol, String]
  # @return [record]
  def authorize(record, action)
    return record if permitted?(record, action)

    raise Pundit::NotAuthorizedError.new(policy: policy(record), query: action, record: record)
  end
end
