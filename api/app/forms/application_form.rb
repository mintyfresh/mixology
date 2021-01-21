# frozen_string_literal: true

class ApplicationForm < Dry::Struct
  module Types
    include Dry.Types

    FileUpload     = Types::Interface(:path, :content_type, :original_filename)
    StrippedString = Types::String.constructor { |value| value.to_s.strip }
  end

  class Fragment < self
  end

  include ActiveModel::Validations

  # Map incoming keys to symbols.
  transform_keys(&:to_sym)

  class << self
    # @param name [Symbol]
    # @param type [Object]
    # @param required [Boolean]
    # @return [void]
    def attribute(name, type = Undefined, optional: true, **options, &block)
      if optional
        type = type.optional
        type = type_with_default(type, options.delete(:default)) unless type.default?
      end

      super(name, type, &block)
    end

    # @param attributes [Hash]
    # @return [Object, ActiveModel::Errors]
    def perform(attributes = {})
      form = new(attributes)
      return form.errors if form.invalid?

      result = catch(:abort) { form.perform }
      return form.errors if form.errors.any?

      result
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, ActiveRecord::RecordNotDestroyed => error
      form.copy_errors(error.record.errors)

      form.errors
    end

  private

    def type_with_default(type, default)
      case default
      when Proc
        type.default { default.call }
      else
        type.default { default }
      end
    end
  end

  # @param errors [ActiveModel::Errors]
  # @param prefix [String, nil]
  # @return [void]
  def copy_errors(errors, prefix: nil)
    errors.each do |error|
      attribute = error.attribute
      attribute = "#{prefix}.#{attribute}" if prefix
      message   = error.message

      self.errors.add(attribute, message)
    end
  end

  # @abstract
  def perform
    raise NotImplementedError, "#{self.class.name} does not implement `#{__method__}`."
  end

  def transaction(**options, &block)
    ApplicationRecord.transaction(**options, &block)
  end
end
