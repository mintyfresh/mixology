import { gql, useMutation } from '@apollo/client';
import React, { useState } from 'react';
import { Button, Form } from 'react-bootstrap';
import { useHistory } from 'react-router-dom';
import { CreateRecipeMutation, CreateRecipeMutationVariables } from '../../graphql/types';
import { ValidationErrorsMap } from '../../lib/validation-errors-map';
import { FormBaseErrors } from '../errors/FormBaseErrors';
import { FormControlErrors } from '../errors/FormControlErrors';
import { RecipeSteps } from './RecipeSteps';

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
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [steps, setSteps] = useState(['', '', '']);

  const history = useHistory();
  const [createRecipe, { data, loading }] = useMutation<CreateRecipeMutation, CreateRecipeMutationVariables>(
    CREATE_RECIPE_MUTATION,
    {
      variables: { input: { name, description, steps } },
      onCompleted: ({ createRecipe }) => {
        if (createRecipe?.recipe) {
          history.push(`/recipes/${createRecipe.recipe.id}`);
        }
      }
    }
  );

  const errors = ValidationErrorsMap.build(data?.createRecipe?.errors);

  return (
    <Form onSubmit={(event) => {
      event.preventDefault();
      createRecipe();
    }}>
      <Form.Group>
        <Form.Label>Name</Form.Label>
        <Form.Control
          name="name"
          value={name}
          onChange={(event) => setName(event.currentTarget.value)}
          isInvalid={errors.isInvalid('name')}
        />
        <FormControlErrors attribute="name" errors={errors} />
      </Form.Group>
      <Form.Group>
        <Form.Label>Description</Form.Label>
        <Form.Control
          as="textarea"
          name="description"
          value={description}
          onChange={(event) => setDescription(event.currentTarget.value)}
          isInvalid={errors.isInvalid('description')}
        />
        <FormControlErrors attribute="description" errors={errors} />
      </Form.Group>
      <RecipeSteps steps={steps} errors={errors} onChange={setSteps} />
      <FormBaseErrors errors={errors} />
      <Form.Group>
        <Button type="submit" disabled={loading}>
          Create Recipe
        </Button>
      </Form.Group>
    </Form>
  );
};
