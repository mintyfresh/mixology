# frozen_string_literal: true

class MixologySchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  # Add `rescue_from` hooks to GraphQL
  use GraphQL::Execution::Errors

  # Load records from the database in batches
  use GraphQL::Batch

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections

  rescue_from(ActiveRecord::RecordNotFound) do |_, _, _, _, field|
    raise GraphQL::ExecutionError.new("#{field.type.unwrap.graphql_name} not found", extensions: { code: 'NOT_FOUND' })
  end

  rescue_from(Pundit::NotAuthorizedError) do |_, _, _, context, _|
    code = context[:current_user].nil? ? 'UNAUTHORIZED' : 'FORBIDDEN'

    raise GraphQL::ExecutionError.new('Action not permitted', extensions: { code: code })
  end
end
