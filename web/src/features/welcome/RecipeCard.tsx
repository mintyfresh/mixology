import { gql } from '@apollo/client';
import React from 'react';
import { Card } from 'react-bootstrap';
import { RecipeCardFragment } from '../../graphql/types';

export const RECIPE_CARD_FRAGMENT = gql`
  fragment RecipeCard on Recipe {
    id
    name
  }
`;

export interface RecipeCardProps {
  recipe: RecipeCardFragment;
}

export const RecipeCard: React.FC<RecipeCardProps> = ({ recipe }) => {
  return (
    <Card id={`recipe-card-${recipe.id}`}>
      <Card.Body>
        <Card.Title>{recipe.name}</Card.Title>
      </Card.Body>
    </Card>
  )
};
