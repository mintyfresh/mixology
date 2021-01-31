import { gql } from '@apollo/client';
import React from 'react';
import { Card } from 'react-bootstrap';
import { IconContext } from 'react-icons';
import { BsStarFill } from 'react-icons/bs';
import { Link } from 'react-router-dom';
import { RecipeCardFragment } from '../../graphql/types';
import { recipePath } from '../../lib/recipe';

const RecipeCardImage: React.FC<{ imageUrl: string }> = ({ imageUrl }) => {
  return (
    <div className="embed-responsive embed-responsive-1by1">
      <Card.Img variant="top" src={imageUrl} className="embed-responsive-item" style={{ objectFit: 'scale-down' }} />
    </div>
  )
};

export const RECIPE_CARD_FRAGMENT = gql`
  fragment RecipeCard on Recipe {
    id
    name
    slug
    imageUrl(usePlaceholder: true)
    averageRating
    reviewsCount

    author {
      id
      displayName
    }
  }
`;

export interface RecipeCardProps {
  recipe: RecipeCardFragment;
}

export const RecipeCard: React.FC<RecipeCardProps> = ({ recipe }) => {
  return (
    <IconContext.Provider value={{ style: { verticalAlign: 'baseline' } }}>
      <Card id={`recipe-card-${recipe.id}`}>
        <RecipeCardImage imageUrl={recipe.imageUrl || ''} />
        <hr className="p-0 m-0" />
        <Card.Body>
          <Card.Title>
            <Link to={recipePath(recipe)}>
              {recipe.name}
            </Link>
          </Card.Title>
          <Card.Subtitle className="text-muted">{recipe.author.displayName}</Card.Subtitle>
          <div className="text-right">
            {recipe.averageRating.toFixed(1)}&nbsp;
            <BsStarFill fill={recipe.averageRating > 0 ? 'gold' : 'grey'} />
          </div>
        </Card.Body>
      </Card>
    </IconContext.Provider>
  )
};
