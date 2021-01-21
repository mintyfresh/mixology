import { gql, useMutation } from '@apollo/client';
import React, { useState } from 'react';
import { Button, Form } from 'react-bootstrap';
import { CreateRecipeMutation, CreateRecipeMutationVariables } from './graphql/types';

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

const RecipeSteps: React.FC<{ steps: string[], onChange?: (steps: string[]) => void }> = ({ steps, onChange }) => {
  const addStep = () => {
    onChange && onChange([...steps, '']);
  };

  const setStep = (index: number, step: string) => {
    const newSteps = [...steps];

    newSteps.splice(index, 1, step);

    onChange && onChange(newSteps);
  };

  const removeStep = (index: number) => {
    const newSteps = [...steps];

    newSteps.splice(index, 1);

    onChange && onChange(newSteps);
  };

  return (
    <>
      <h4 className="text-center">
        Preparation Instructions
      </h4>
      {steps.map((step, index) =>
        <Form.Group key={index}>
          <div>
            <Form.Label>
              Step {index + 1}
            </Form.Label>
            <Button className="float-right text-danger p-0" variant="link" onClick={() => removeStep(index)}>
              Remove
            </Button>
          </div>
          <Form.Control
            as="textarea"
            name={`steps[${index}].body`}
            value={step}
            onChange={(event) => setStep(index, event.currentTarget.value)}
          />
        </Form.Group>
      )}
      <div className="text-center">
        <Button className="text-primary p-0" variant="link" onClick={() => addStep()}>
          Add a Step
        </Button>
      </div>
    </>
  );
};

export const CreateRecipe: React.FC = () => {
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [steps, setSteps] = useState(['', '', '']);
  const [createRecipe, { data, loading }] = useMutation<CreateRecipeMutation, CreateRecipeMutationVariables>(
    CREATE_RECIPE_MUTATION, { variables: { input: { name, description, steps } } }
  );

  console.log(data);

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
        />
      </Form.Group>
      <Form.Group>
        <Form.Label>Description</Form.Label>
        <Form.Control
          as="textarea"
          name="description"
          value={description}
          onChange={(event) => setDescription(event.currentTarget.value)}
        />
      </Form.Group>
      <RecipeSteps steps={steps} onChange={setSteps} />
      <Form.Group>
        <Button type="submit" disabled={loading}>
          Create Recipe
        </Button>
      </Form.Group>
    </Form>
  );
};
