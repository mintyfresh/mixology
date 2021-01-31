import React from 'react';
import { Button, Form } from 'react-bootstrap';
import { ValidationErrorsMap } from '../../lib/validation-errors-map';
import { FormControlErrors } from '../errors/FormControlErrors';

export interface RecipeStepsProps {
  steps: string[];
  errors: ValidationErrorsMap;
  onChange?: (steps: string[]) => void;
}

export const RecipeSteps: React.FC<RecipeStepsProps> = ({ steps, errors, onChange }) => {
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
            isInvalid={errors.isInvalid(`steps[${index}].body`)}
          />
          <FormControlErrors attribute={`steps[${index}].body`} errors={errors} />
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