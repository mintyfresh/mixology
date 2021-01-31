import React from 'react';
import { Button, Form } from 'react-bootstrap';
import { RecipeInput } from '../../graphql/types';
import { ValidationErrorsMap } from '../../lib/validation-errors-map';
import { FormBaseErrors } from '../errors/FormBaseErrors';
import { FormControlErrors } from '../errors/FormControlErrors';
import { RecipeSteps } from './RecipeSteps';

export interface RecipeFormProps {
  cta: string;
  recipe: RecipeInput;
  onRecipeChange?: (recipe: RecipeInput) => void;
  errors: ValidationErrorsMap;
  onCancel?: () => void;
  onSubmit?: (recipe: RecipeInput) => void;
  submitted?: boolean;
}

export const RecipeForm: React.FC<RecipeFormProps> = ({ cta, recipe, onRecipeChange, errors, onCancel, onSubmit, submitted }) => {
  const name = recipe.name;
  const description = recipe.description || '';
  const steps = recipe.steps || [''];

  const onChange = (change: Partial<RecipeInput>) => {
    onRecipeChange && onRecipeChange({ ...recipe, ...change });
  }

  return (
    <Form onSubmit={(event) => {
      event.preventDefault();
      onSubmit && onSubmit(recipe);
    }}>
      <Form.Group>
        <Form.Label>Name</Form.Label>
        <Form.Control
          name="name"
          value={name}
          onChange={(event) => onChange({ name: event.currentTarget.value })}
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
          onChange={(event) => onChange({ description: event.currentTarget.value })}
          isInvalid={errors.isInvalid('description')}
        />
        <FormControlErrors attribute="description" errors={errors} />
      </Form.Group>
      <RecipeSteps steps={steps} errors={errors} onChange={(steps) => onChange({ steps })} />
      <FormBaseErrors errors={errors} />
      <Form.Group className="text-right">
        {onCancel &&
          <Button type="button" variant="secondary" className="float-left" onClick={() => onCancel()}>
            Cancel
          </Button>
        }
        <Button type="submit" disabled={submitted}>
          {cta}
        </Button>
      </Form.Group>
    </Form>
  );
};
