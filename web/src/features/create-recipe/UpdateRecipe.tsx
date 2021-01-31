import { gql, useLazyQuery, useMutation } from '@apollo/client';
import React, { useEffect, useState } from 'react';
import { Redirect, useHistory, useParams } from 'react-router-dom';
import { RecipeForUpdateQuery, RecipeForUpdateQueryVariables, RecipeInput, UpdateRecipeMutation, UpdateRecipeMutationVariables } from '../../graphql/types';
import { extractIdFromSlug } from '../../lib/extract-id-from-slug';
import { recipePath } from '../../lib/recipe';
import { useCanonicalSlug } from '../../lib/use-canonical-slug';
import { ValidationErrorsMap, VALIDATION_ERROR_FRAGMENT } from '../../lib/validation-errors-map';
import { RecipeForm } from './RecipeForm';

const RECIPE_FOR_UPDATE_QUERY = gql`
  query RecipeForUpdate($id: ID!) {
    recipe(id: $id) {
      id
      name
      slug
      description
      steps {
        body
      }
    }
  }
`;

const UPDATE_RECIPE_MUTATION = gql`
  mutation UpdateRecipe($id: ID!, $input: RecipeInput!) {
    updateRecipe(id: $id, input: $input) {
      recipe {
        id
        slug
      }
      errors {
        ...ValidationError
      }
    }
  }
  ${VALIDATION_ERROR_FRAGMENT}
`;

export const UpdateRecipe: React.FC = () => {
  const [recipe, setRecipe] = useState<RecipeInput>({
    name: '',
    description: '',
    steps: ['']
  });

  const { slug } = useParams<{ slug: string }>();
  const id = extractIdFromSlug(slug);
  const [getRecipe, { called, data }] = useLazyQuery<RecipeForUpdateQuery, RecipeForUpdateQueryVariables>(
    RECIPE_FOR_UPDATE_QUERY,
    {
      fetchPolicy: 'network-only',
      onCompleted: ({ recipe }) => {
        if (recipe) {
          setRecipe({
            name: recipe.name,
            description: recipe.description,
            steps: recipe.steps.map(({ body }) => body)
          });
        }
      }
    }
  );

  const history = useHistory();
  const [updateRecipe, mutation] = useMutation<UpdateRecipeMutation, UpdateRecipeMutationVariables>(
    UPDATE_RECIPE_MUTATION,
    {
      onCompleted: ({ updateRecipe }) => {
        if (updateRecipe?.recipe?.slug) {
          history.push(recipePath(updateRecipe.recipe));
        }
      }
    }
  );

  useCanonicalSlug(slug, data?.recipe.slug);

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

  if (!data?.recipe) {
    return null;
  }

  return (
    <RecipeForm
      cta="Update Recipe"
      errors={ValidationErrorsMap.build(mutation.data?.updateRecipe?.errors)}
      recipe={recipe}
      onRecipeChange={setRecipe}
      onCancel={() => {
        history.push(recipePath(data.recipe));
      }}
      submitted={mutation.loading}
      onSubmit={(recipe) => {
        updateRecipe({
          variables: { id, input: recipe }
        });
      }}
    />
  );
};
