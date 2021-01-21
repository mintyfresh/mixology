# frozen_string_literal: true

class NestedValidator < ActiveModel::EachValidator
  # @param form [ApplicationForm]
  # @param attribute [Symbol]
  # @param value [String, nil]
  # @return [void]
  def validate_each(form, attribute, value)
    if value.respond_to?(:each)
      value.each.with_index do |element, index|
        next if element.blank? || element.valid?

        form.copy_errors(element.errors, prefix: "#{attribute}[#{index}]")
      end
    else
      return if value.blank? || value.valid?

      form.copy_errors(value.errors, prefix: attribute)
    end
  end
end
