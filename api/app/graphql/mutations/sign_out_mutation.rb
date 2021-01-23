# frozen_string_literal: true

module Mutations
  class SignOutMutation < BaseMutation
    field :success, Boolean, null: true

    def resolve
      current_session&.revoke!

      { success: true }
    end
  end
end
