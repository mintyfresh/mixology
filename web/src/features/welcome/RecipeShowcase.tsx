import { gql } from '@apollo/client';
import React from 'react';
import { Col, Row } from 'react-bootstrap';
import { RecipeShowcaseFragment } from '../../graphql/types';
import { RecipeCard, RECIPE_CARD_FRAGMENT } from './RecipeCard';


export const RECIPE_SHOWCASE_FRAGMENT = gql`
  fragment RecipeShowcase on RecipeConnection {
    nodes {
      ...RecipeCard
    }
    pageInfo {
      hasNextPage
      endCursor
    }
  }
  ${RECIPE_CARD_FRAGMENT}
`;

export interface RecipeShowcaseProps {
  title: string;
  recipes: RecipeShowcaseFragment;
}

export const RecipeShowcase: React.FC<RecipeShowcaseProps> = ({ title, recipes }) => {
  return (
    <div>
      <h2>{title}</h2>
      <Row>
        {recipes.nodes.map((recipe) =>
          <Col xs="4" key={recipe.id} className="mb-3">
            <RecipeCard recipe={recipe} />
          </Col>
        )}
      </Row>
    </div>
  );
};
