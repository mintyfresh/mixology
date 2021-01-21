# frozen_string_literal: true

module Loaders
  class ExistenceLoader < BaseLoader
    # @param model [Class<ActiveRecord::Base>]
    # @param column [Symbol, String]
    # @param scope [ActiveRecord::Relation, nil]
    def self.loader_key_for(model, column = model.primary_key, scope: nil)
      [model, column.to_s, scope&.to_sql]
    end

    # @param model [Class<ActiveRecord::Base>]
    # @param column [Symbol, String]
    # @param scope [ActiveRecord::Relation, nil]
    def initialize(model, column = model.primary_key, scope: nil)
      super()

      @model       = model
      @column      = column.to_s
      @column_type = model.type_for_attribute(@column)
      @scope       = scope
    end

    def load(key)
      super(@column_type.cast(key))
    end

    def perform(keys)
      keyset = build_existence_keyset

      keys.each { |key| fulfill(key, keyset.include?(key)) }
    end

  private

    def build_existence_keyset
      records = @model.all.distinct
      records = records.merge(@scope) if @scope
      records = records.pluck(@column)

      records.to_set
    end
  end
end
