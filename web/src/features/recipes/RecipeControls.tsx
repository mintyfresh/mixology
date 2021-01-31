import { gql, useMutation } from '@apollo/client';
import React from 'react';
import { Dropdown, DropdownButton } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { useHistory } from 'react-router-dom';
import { DeleteRecipeMutation, DeleteRecipeMutationVariables, RecipeControlsFragment } from '../../graphql/types';

const DELETE_RECIPE_MUTATION = gql`
  mutation DeleteRecipe($id: ID!) {
    deleteRecipe(id: $id) {
      success
    }
  }
`;

interface DeleteRecipeItemProps {
  recipe: RecipeControlsFragment;
}

const DeleteRecipeItem: React.FC<DeleteRecipeItemProps> = ({ recipe }) => {
  const history = useHistory();
  const [deleteRecipe, { loading }] = useMutation<DeleteRecipeMutation, DeleteRecipeMutationVariables>(
    DELETE_RECIPE_MUTATION,
    {
      onCompleted: ({ deleteRecipe }) => {
        if (deleteRecipe?.success) {
          history.push('/my-recipes');
        }
      }
    }
  );

  return (
    <Dropdown.Item
      className="text-danger"
      disabled={loading}
      onClick={() => {
        deleteRecipe({
          variables: { id: recipe.id }
        });
      }}
    >
      Delete
    </Dropdown.Item>
  );
};

export const RECIPE_CONTROLS_FRAGMENT = gql`
  fragment RecipeControls on Recipe {
    id
    permissions {
      canUpdate
      canDelete
    }
  }
`;

export interface RecipeControlsProps {
  recipe: RecipeControlsFragment;
}

export const RecipeControls: React.FC<RecipeControlsProps> = ({ recipe }) => {
  const actions: JSX.Element[] = [];

  if (recipe.permissions.canUpdate) {
    actions.push(
      <LinkContainer to={`/recipes/${recipe.id}/edit`} key="edit">
        <Dropdown.Item>Edit</Dropdown.Item>
      </LinkContainer>
    );
  }

  if (recipe.permissions.canDelete) {
    actions.push(
      <DeleteRecipeItem recipe={recipe} key="delete" />
    );
  }

  if (actions.length === 0) {
    return null;
  }

  return (
    <DropdownButton id={`recipes-${recipe.id}-controls`} title="Controls" alignRight>
      {actions}
    </DropdownButton>
  )
};