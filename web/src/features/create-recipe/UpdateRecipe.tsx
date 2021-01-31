import { gql, useMutation, useQuery } from '@apollo/client';
import React, { useState } from 'react';
import { useHistory, useParams } from 'react-router-dom';
import { RecipeForUpdateQuery, RecipeForUpdateQueryVariables, RecipeInput, UpdateRecipeMutation, UpdateRecipeMutationVariables } from '../../graphql/types';
import { ValidationErrorsMap, VALIDATION_ERROR_FRAGMENT } from '../../lib/validation-errors-map';
import { RecipeForm } from './RecipeForm';

const RECIPE_FOR_UPDATE_QUERY = gql`
  query RecipeForUpdate($id: ID!) {
    recipe(id: $id) {
      id
      name
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

  const { id } = useParams<{ id: string }>();
  const { data } = useQuery<RecipeForUpdateQuery, RecipeForUpdateQueryVariables>(RECIPE_FOR_UPDATE_QUERY, {
    variables: { id },
    onCompleted: ({ recipe }) => {
      if (recipe) {
        setRecipe({
          name: recipe.name,
          description: recipe.description,
          steps: recipe.steps.map(({ body }) => body)
        });
      }
    }
  });

  const history = useHistory();
  const [updateRecipe, mutation] = useMutation<UpdateRecipeMutation, UpdateRecipeMutationVariables>(UPDATE_RECIPE_MUTATION, {
    onCompleted: ({ updateRecipe }) => {
      if (updateRecipe?.recipe?.id) {
        history.push(`/recipes/${updateRecipe.recipe.id}`);
      }
    }
  });

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
        history.push(`/recipes/${id}`);
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
