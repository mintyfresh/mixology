import { gql, useMutation } from '@apollo/client';
import React from 'react';
import { useHistory } from 'react-router-dom';
import { CreateRecipeMutation, CreateRecipeMutationVariables } from '../../graphql/types';
import { ValidationErrorsMap } from '../../lib/validation-errors-map';
import { RecipeForm } from './RecipeForm';

const CREATE_RECIPE_MUTATION = gql`
  mutation CreateRecipe($input: CreateRecipeInput!) {
    createRecipe(input: $input) {
      recipe {
        id
        name
        description
        steps {
          id
          body
        }
      }
      errors {
        attribute
        message
      }
    }
  }
`;

export const CreateRecipe: React.FC = () => {
  const history = useHistory();
  const [createRecipe, { data }] = useMutation<CreateRecipeMutation, CreateRecipeMutationVariables>(
    CREATE_RECIPE_MUTATION,
    {
      onCompleted: ({ createRecipe }) => {
        if (createRecipe?.recipe) {
          history.push(`/recipes/${createRecipe.recipe.id}`);
        }
      }
    }
  );

  const errors = ValidationErrorsMap.build(data?.createRecipe?.errors);

  return (
    <RecipeForm
      cta="Create Recipe"
      onSubmit={(recipe) => {
        createRecipe({ variables: { input: recipe } });
      }}
      errors={errors}
    />
  )
};
