import React, { useEffect, useState } from 'react';
import { Form, Button } from 'react-bootstrap';
import { CreateRecipeInput } from '../../graphql/types';
import { ValidationErrorsMap } from '../../lib/validation-errors-map';
import { FormBaseErrors } from '../errors/FormBaseErrors';
import { FormControlErrors } from '../errors/FormControlErrors';
import { RecipeSteps } from './RecipeSteps';

export interface RecipeFormProps {
  cta: string;
  recipe?: CreateRecipeInput;
  onSubmit?: (recipe: CreateRecipeInput) => void;
  errors: ValidationErrorsMap;
}

export const RecipeForm: React.FC<RecipeFormProps> = ({ cta, recipe, errors, onSubmit }) => {
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [steps, setSteps] = useState(['']);

  useEffect(() => {
    if (recipe) {
      setName(recipe.name);
      setDescription(recipe.description || description);
      setSteps(recipe.steps || steps);
    }
  }, [recipe, setName, setDescription, description, setSteps, steps]);

  return (
    <Form onSubmit={(event) => {
      event.preventDefault();
      onSubmit && onSubmit({
        name, description, steps
      });
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
        <Button type="submit">{cta}</Button>
      </Form.Group>
    </Form>
  );
};
