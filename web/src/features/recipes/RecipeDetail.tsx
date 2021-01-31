import { gql, useLazyQuery } from '@apollo/client';
import React, { useEffect } from 'react';
import { Card } from 'react-bootstrap';
import { Redirect, useParams } from 'react-router-dom';
import { RecipeDetailQuery, RecipeDetailQueryVariables } from '../../graphql/types';
import { extractIdFromSlug } from '../../lib/extract-id-from-slug';
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
  const { slug } = useParams<{ slug: string }>();
  const id = extractIdFromSlug(slug);
  const [getRecipe, { called, data }] = useLazyQuery<RecipeDetailQuery, RecipeDetailQueryVariables>(RECIPE_DETAIL_QUERY);

  useEffect(() => {
    if (id && !called) {
      getRecipe({
        variables: { id }
      });
    }
  }, [id, called, getRecipe]);

  if (!id) {
    return (
      // TODO: Add not-found page.
      <Redirect to="/" />
    );
  }

  if (!data) {
    return (
      <p>Loading...</p>
    );
  }

  return (
    <>
      <div className="float-right">
        <RecipeControls recipe={data.recipe} />
      </div>
      <h1>{data.recipe.name}</h1>
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
