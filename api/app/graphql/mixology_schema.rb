# frozen_string_literal: true

class MixologySchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Load records from the database in batches
  use GraphQL::Batch

  rescue_from(ActiveRecord::RecordNotFound) do |_, _, _, _, field|
    raise GraphQL::ExecutionError.new("#{field.type.unwrap.graphql_name} not found", extensions: { code: 'NOT_FOUND' })
  end

  rescue_from(Pundit::NotAuthorizedError) do |_, _, _, context, _|
    code = context[:current_user].nil? ? 'UNAUTHORIZED' : 'FORBIDDEN'

    raise GraphQL::ExecutionError.new('Action not permitted', extensions: { code: code })
  end
end
