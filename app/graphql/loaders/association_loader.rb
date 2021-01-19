# frozen_string_literal: true

module Loaders
  class AssociationLoader < BaseLoader
    # @param model [Class<ActiveRecord::Base>]
    # @param association_name [Symbol, String]
    def initialize(model, association_name)
      super()

      @model       = model
      @association = model.reflect_on_association(association_name)

      raise ArgumentError, "Unknown assocation #{association_name} for class #{model.name}" if @association.nil?
    end

    def load(record)
      raise TypeError, "#{@model} loader can't load association for #{record.class}" unless record.is_a?(@model)
      return Promise.resolve(read_association(record)) if association_loaded?(record)

      super
    end

    # We want to load the associations on all records, even if they have the same id
    def cache_key(record)
      record.object_id
    end

    def perform(records)
      preload_association(records)
      records.each { |record| fulfill(record, read_association(record)) }
    end

  private

    def preload_association(records)
      ::ActiveRecord::Associations::Preloader.new.preload(records, @association.name)
    end

    def read_association(record)
      record.public_send(@association.name)
    end

    def association_loaded?(record)
      record.association(@association.name).loaded?
    end
  end
end
