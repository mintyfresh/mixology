# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :sign_in,  mutation: Mutations::SignInMutation
    field :sign_up,  mutation: Mutations::SignUpMutation
    field :sign_out, mutation: Mutations::SignOutMutation

    field :confirm_email, mutation: Mutations::ConfirmEmailMutation

    field :change_password, mutation: Mutations::ChangePasswordMutation

    field :create_recipe, mutation: Mutations::CreateRecipeMutation
    field :delete_recipe, mutation: Mutations::DeleteRecipeMutation
    field :update_recipe, mutation: Mutations::UpdateRecipeMutation
    field :add_favourite_recipe, mutation: Mutations::AddFavouriteRecipeMutation
    field :remove_favourite_recipe, mutation: Mutations::RemoveFavouriteRecipeMutation

    field :create_review, mutation: Mutations::CreateReviewMutation
  end
end
