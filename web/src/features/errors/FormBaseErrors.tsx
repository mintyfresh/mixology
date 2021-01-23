import React from 'react';
import { Alert } from 'react-bootstrap';
import { ValidationErrorsMap } from '../../lib/validation-errors-map';

export interface FormBaseErrorsProps {
  errors: ValidationErrorsMap;
}

export const FormBaseErrors: React.FC<FormBaseErrorsProps> = ({ errors }) => {
  const messages = errors.base();

  if (messages.length === 0) {
    return null;
  }

  return (
    <Alert variant="danger">
      {messages.map((message, index) =>
        <div key={index}>{message}</div>
      )}
    </Alert>
  );
};
