import { gql } from '@apollo/client';
import React from 'react';
import { Link } from 'react-router-dom';
import { RecipeIngredientsFragment } from '../../graphql/types';

export const RECIPE_INGREDIENTS_FRAGMENT = gql`
  fragment RecipeIngredients on Recipe {
    ingredients {
      id
      name
      quantity
    }
  }
`;

export const RecipeIngredients: React.FC<RecipeIngredientsFragment> = ({ ingredients }) => {
  return (
    <>
      <h2>Ingredients</h2>
      <ul>
        {ingredients.map((ingredient) =>
          <li key={ingredient.id}>
            <Link to={`/ingredients/${ingredient.id}`}>
              {ingredient.name}
            </Link>
            {ingredient.quantity &&
              <span> - {ingredient.quantity}</span>
            }
          </li>
        )}
      </ul>
    </>
  )
};
