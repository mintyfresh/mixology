import { gql, useQuery } from '@apollo/client';
import React from 'react';
import { Card } from 'react-bootstrap';
import { useParams } from 'react-router-dom';
import { RecipeDetailQuery, RecipeDetailQueryVariables } from '../../graphql/types';
import { RecipeControls, RECIPE_CONTROLS_FRAGMENT } from './RecipeControls';
import { RecipeEquipments, RECIPE_EQUIPMENTS_FRAGMENT } from './RecipeEquipments';
import { RecipeIngredients, RECIPE_INGREDIENTS_FRAGMENT } from './RecipeIngredients';

const RECIPE_DETAIL_QUERY = gql`
  query RecipeDetail($id: ID!) {
    recipe(id: $id) {
      id
      name
      description
      ...RecipeControls
      ...RecipeIngredients
      ...RecipeEquipments
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
  ${RECIPE_CONTROLS_FRAGMENT}
  ${RECIPE_INGREDIENTS_FRAGMENT}
  ${RECIPE_EQUIPMENTS_FRAGMENT}
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
      <div className="float-right">
        <RecipeControls recipe={data.recipe} />
      </div>
      {data.recipe.description &&
        <p>{data.recipe.description}</p>
      }
      <RecipeIngredients ingredients={data.recipe.ingredients} />
      <RecipeEquipments equipments={data.recipe.equipments} />
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
