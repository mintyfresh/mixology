# frozen_string_literal: true

class GraphqlController < ApplicationController
  def execute
    query          = params[:query]
    operation_name = params[:operationName]
    variables      = parse_variables(params[:variables])
    context        = build_context

    render json: MixologySchema.execute(query, variables: variables, context: context, operation_name: operation_name)
  end

private

  # Handle variables in form data, JSON body, or a blank value
  # @param variables_params [String, Hash, ActionController::Parameters, nil]
  # @return [Hash]
  def parse_variables(variables_param) # rubocop:disable Metrics/MethodLength
    case variables_param
    when String
      variables_param.present? ? JSON.parse(variables_param) || {} : {}
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end
end
