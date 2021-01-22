# frozen_string_literal: true

module Types
  class BasePermissions < BaseObject
    # @param name [Symbol]
    # @param action [Symbol]
    # @param resolver_method [Symbol]
    # @return [void]
    def self.policy_permission(name, action: :"#{name}?", resolver_method: name)
      permission(name, resolver_method: resolver_method)
      define_method(resolver_method) { permitted?(object, action) }
    end

    # @param name [Symbol]
    # @param resolver_method [Symbol]
    # @return [void]
    def self.permission(name, resolver_method: name)
      field(:"can_#{name}", Boolean, null: false, resolver_method: resolver_method) do
        description("Indicates whether the current user can `#{name}` this object.")
      end
    end
  end
end
