import React from 'react';
import { Form } from 'react-bootstrap';
import { ValidationErrorsMap } from '../../lib/validation-errors-map';

export interface FormControlErrorsProps {
  attribute: string;
  errors: ValidationErrorsMap;
}

export const FormControlErrors: React.FC<FormControlErrorsProps> = ({ attribute, errors }) => {
  const messages = errors.on(attribute);

  if (messages.length === 0) {
    return null;
  }

  return (
    <Form.Control.Feedback type="invalid">
      {messages.map((message, index) =>
        <div key={index}>{message}</div>
      )}
    </Form.Control.Feedback>
  );
};
