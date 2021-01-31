import { gql } from '@apollo/client';
import React from 'react';
import { Dropdown, DropdownButton } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { RecipeControlsFragment } from '../../graphql/types';

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
      <LinkContainer to={`/recipes/${recipe.id}/edit`} key="delete">
        <Dropdown.Item className="text-danger">Delete</Dropdown.Item>
      </LinkContainer>
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