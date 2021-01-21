# frozen_string_literal: true

module Loaders
  class RecordLoader < BaseLoader
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
      query(keys).each { |record| fulfill(record.public_send(@column), record) }
      keys.each { |key| fulfill(key, nil) unless fulfilled?(key) }
    end

  private

    def query(keys)
      records = @model.where(@column => keys)
      records = records.merge(@scope) if @scope

      records
    end
  end
end
