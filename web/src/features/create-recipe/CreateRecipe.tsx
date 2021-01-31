import { gql, useMutation } from '@apollo/client';
import React, { useState } from 'react';
import { useHistory } from 'react-router-dom';
import { CreateRecipeMutation, CreateRecipeMutationVariables, RecipeInput } from '../../graphql/types';
import { recipePath } from '../../lib/recipe';
import { ValidationErrorsMap } from '../../lib/validation-errors-map';
import { RecipeForm } from './RecipeForm';

const CREATE_RECIPE_MUTATION = gql`
  mutation CreateRecipe($input: RecipeInput!) {
    createRecipe(input: $input) {
      recipe {
        id
        name
        slug
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
  const [recipe, setRecipe] = useState<RecipeInput>({
    name: '',
    description: '',
    steps: ['']
  });

  const history = useHistory();
  const [createRecipe, { data, loading }] = useMutation<CreateRecipeMutation, CreateRecipeMutationVariables>(
    CREATE_RECIPE_MUTATION,
    {
      onCompleted: ({ createRecipe }) => {
        if (createRecipe?.recipe) {
          history.push(recipePath(createRecipe.recipe));
        }
      }
    }
  );

  const errors = ValidationErrorsMap.build(data?.createRecipe?.errors);

  return (
    <RecipeForm
      cta="Create Recipe"
      recipe={recipe}
      onRecipeChange={setRecipe}
      errors={errors}
      submitted={loading}
      onSubmit={(recipe) => {
        createRecipe({ variables: { input: recipe } });
      }}
    />
  )
};
