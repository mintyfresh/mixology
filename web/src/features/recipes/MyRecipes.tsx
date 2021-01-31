import { gql, useQuery } from '@apollo/client';
import { Card } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import { MyRecipesQuery } from '../../graphql/types';
import { recipePath } from '../../lib/recipe';

const MY_RECIPES_QUERY = gql`
  query MyRecipes {
    currentUser {
      id
      authoredRecipes {
        nodes {
          id
          name
          slug
          description
        }
      }
    }
  }
`;

export const MyRecipes: React.FC = () => {
  const { data } = useQuery<MyRecipesQuery>(MY_RECIPES_QUERY);

  if (!data?.currentUser) {
    return null;
  }

  return (
    <>
      {data.currentUser.authoredRecipes.nodes.map((recipe) =>
        <Card key={recipe.id} className="mb-2">
          <Card.Body>
            <Card.Title>
              <Link to={recipePath(recipe)}>
                {recipe.name}
              </Link>
            </Card.Title>
            {recipe.description &&
              <Card.Text>{recipe.description}</Card.Text>
            }
          </Card.Body>
        </Card>
      )}
    </>
  );
};
