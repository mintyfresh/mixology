import { gql, useMutation } from '@apollo/client';
import React, { useState } from 'react';
import { Alert, Button, Form } from 'react-bootstrap';
import { RequestPasswordResetMutation, RequestPasswordResetMutationVariables } from '../../graphql/types';
import { ValidationErrorsMap, VALIDATION_ERROR_FRAGMENT } from '../../lib/validation-errors-map';
import { FormBaseErrors } from '../errors/FormBaseErrors';
import { FormControlErrors } from '../errors/FormControlErrors';

const REQUEST_PASSWORD_RESET_MUTATION = gql`
  mutation RequestPasswordReset($email: String!) {
    requestPasswordReset(email: $email) {
      success
      errors {
        ...ValidationError
      }
    }
  }
  ${VALIDATION_ERROR_FRAGMENT}
`;

export const ForgotPassword = () => {
  const [email, setEmail] = useState('');
  const [requestPasswordReset, { data, loading }] = useMutation<RequestPasswordResetMutation, RequestPasswordResetMutationVariables>(
    REQUEST_PASSWORD_RESET_MUTATION
  );
  const errors = ValidationErrorsMap.build(data?.requestPasswordReset?.errors);

  if (data?.requestPasswordReset?.success) {
    return (
      <Alert variant="info">
        We're sending a recovery link to <u>{email}</u> to reset your password and recover your account.
        <br />
        It may take up to 15 minutes for the email to arrive.
        <br />
        Be sure to check your spam/junk folder if it doesn't appear in your inbox.
      </Alert>
    );
  }

  return (
    <Form onSubmit={(event) => {
      event.preventDefault();
      requestPasswordReset({
        variables: { email }
      });
    }}>
      <Form.Group>
        <Form.Label>Account Email</Form.Label>
        <Form.Control
          name="email"
          type="email"
          autoComplete="username email"
          value={email}
          onChange={(event) => setEmail(event.currentTarget.value)}
          isInvalid={errors.isInvalid('email')}
        />
        <Form.Text muted>
          We'll send you a recovery link so you can reset your password.
        </Form.Text>
        <FormControlErrors attribute="email" errors={errors} />
      </Form.Group>
      <FormBaseErrors errors={errors} />
      <Form.Group className="text-right">
        <Button type="submit" disabled={loading}>Reset Password</Button>
      </Form.Group>
    </Form>
  )
};
