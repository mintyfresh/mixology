import { gql, useQuery } from '@apollo/client';
import React from 'react';
import { useParams } from 'react-router-dom';
import { RecipeDetailQuery, RecipeDetailQueryVariables } from './graphql/types';

const RECIPE_DETAIL_QUERY = gql`
  query RecipeDetail($id: ID!) {
    recipe(id: $id) {
      id
      name
      description
      ingredients {
        id
        name
        quantity
      }
      equipments {
        id
        name
        quantity
      }
      steps {
        id
        body
      }
    }
  }
`;

export const RecipeDetail: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const { data, error } = useQuery<RecipeDetailQuery, RecipeDetailQueryVariables>(
    RECIPE_DETAIL_QUERY,
    { variables: { id } }
  );

  if (error) {
    // TODO
    console.log(error);

    return null;
  }

  if (!data) {
    return (
      <p>Loading...</p>
    );
  }

  return (
    <>
      <h1>{data.recipe.name}</h1>
      {data.recipe.description &&
        <p>{data.recipe.description}</p>
      }
      <h2>Ingredients</h2>
      <ul>
        {data.recipe.ingredients.map((ingredient) =>
          <li key={ingredient.id}>
            {ingredient.name}
            {ingredient.quantity &&
              <span> - {ingredient.quantity}</span>
            }
          </li>
        )}
      </ul>
      <h2>Equipment</h2>
      <ul>
        {data.recipe.equipments.map((equipment) =>
          <li key={equipment.id}>
            {equipment.name}
            {equipment.quantity &&
              <span className="text-secondary"> - &times;{equipment.quantity}</span>
            }
          </li>
        )}
      </ul>
      <h2>Preparation Instructions</h2>
      <ul>
        {data.recipe.steps.map((step) =>
          <li key={step.id}>
            {step.body}
          </li>
        )}
      </ul>
    </>
  );
};
