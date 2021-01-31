# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :sign_in,  mutation: Mutations::SignInMutation
    field :sign_up,  mutation: Mutations::SignUpMutation
    field :sign_out, mutation: Mutations::SignOutMutation

    field :confirm_email, mutation: Mutations::ConfirmEmailMutation

    field :request_password_reset, mutation: Mutations::RequestPasswordResetMutation
    field :perform_password_reset, mutation: Mutations::PerformPasswordResetMutation

    field :change_password, mutation: Mutations::ChangePasswordMutation

    field :create_recipe, mutation: Mutations::CreateRecipeMutation
    field :delete_recipe, mutation: Mutations::DeleteRecipeMutation
    field :update_recipe, mutation: Mutations::UpdateRecipeMutation
    field :report_recipe, mutation: Mutations::ReportRecipeMutation
    field :add_favourite_recipe, mutation: Mutations::AddFavouriteRecipeMutation
    field :remove_favourite_recipe, mutation: Mutations::RemoveFavouriteRecipeMutation

    field :create_review, mutation: Mutations::CreateReviewMutation
    field :report_review, mutation: Mutations::ReportReviewMutation
  end
end
