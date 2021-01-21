import React from 'react';
import { Form } from 'react-bootstrap';

export const CreateRecipe: React.FC = () => {
  return (
    <Form>
      <Form.Group>
        <Form.Label>Name</Form.Label>
        <Form.Control />
      </Form.Group>
    </Form>
  );
};
