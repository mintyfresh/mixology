import { gql, useQuery } from '@apollo/client';
import React from 'react';
import { Card } from 'react-bootstrap';
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
      reviews(first: 5) {
        nodes {
          id
          body
          rating
          author {
            id
            displayName
          }
        }
        pageInfo {
          hasNextPage
          endCursor
        }
      }
    }
  }
`;

export const RecipeDetail: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const { data } = useQuery<RecipeDetailQuery, RecipeDetailQueryVariables>(
    RECIPE_DETAIL_QUERY,
    { variables: { id } }
  );

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
      <hr />
      <h2>Reviews</h2>
      {data.recipe.reviews.nodes.map((review) =>
        <Card key={review.id} className="mb-2">
          <Card.Body>
            <Card.Title>{review.author.displayName}</Card.Title>
            <Card.Text>{review.body}</Card.Text>
          </Card.Body>
        </Card>
      )}
    </>
  );
};
