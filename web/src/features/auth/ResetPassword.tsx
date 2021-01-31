import { gql, useLazyQuery, useMutation } from '@apollo/client';
import React, { useEffect, useState } from 'react';
import { Alert, Button, Form } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { Redirect } from 'react-router-dom';
import { PasswordResetQuery, PasswordResetQueryVariables, ResetPasswordMutation, ResetPasswordMutationVariables } from '../../graphql/types';
import { useSearchParams } from '../../lib/use-search-params';
import { ValidationErrorsMap, VALIDATION_ERROR_FRAGMENT } from '../../lib/validation-errors-map';
import { FormBaseErrors } from '../errors/FormBaseErrors';
import { FormControlErrors } from '../errors/FormControlErrors';

const PASSWORD_RESET_QUERY = gql`
  query PasswordReset($token: String!) {
    passwordReset(token: $token) {
      email
      expired
    }
  }
`;

const RESET_PASSWORD_MUTATION = gql`
  mutation ResetPassword($token: String!, $input: PerformPasswordResetInput!) {
    performPasswordReset(token: $token, input: $input) {
      success
      errors {
        ...ValidationError
      }
    }
  }
  ${VALIDATION_ERROR_FRAGMENT}
`;

export const ResetPassword = () => {
  const searchParams = useSearchParams();
  const token = searchParams.get('token');

  const [newPassword, setNewPassword] = useState('');
  const [newPasswordConfirmation, setNewPasswordConfirmation] = useState('');

  const [getPasswordReset, query] = useLazyQuery<PasswordResetQuery, PasswordResetQueryVariables>(PASSWORD_RESET_QUERY);
  const email = query.data?.passwordReset.email;

  const [resetPassword, { data, loading }] = useMutation<ResetPasswordMutation, ResetPasswordMutationVariables>(RESET_PASSWORD_MUTATION);
  const errors = ValidationErrorsMap.build(data?.performPasswordReset?.errors);

  useEffect(() => {
    if (token && !query.called) {
      getPasswordReset({
        variables: { token }
      });
    }
  }, [token, query.called, getPasswordReset]);

  if (!token) {
    return (
      <Redirect to="/forgot-password" />
    );
  }

  if (query.loading) {
    return null;
  }

  if (!query.data?.passwordReset) {
    return (
      <Alert variant="warning">
        This password recovery link has already been used or is otherwise invalid.
        <br />
        If you're still trying to recover your password,{' '}
        <LinkContainer to="/forgot-password">
          <Alert.Link>click here to send another recovery email.</Alert.Link>
        </LinkContainer>
      </Alert>
    );
  }

  if (query.data?.passwordReset.expired) {
    return (
      <Alert variant="warning">
        This password recovery link has expired.
        <br />
        If you're still trying to recover your password,{' '}
        <LinkContainer to="/forgot-password">
          <Alert.Link>click here to send another recovery email.</Alert.Link>
        </LinkContainer>
      </Alert>
    );
  }

  if (data?.performPasswordReset?.success) {
    return (
      <Alert variant="success">
        Your new password has been saved. You can now sign in to your account.
      </Alert>
    );
  }

  return (
    <Form onSubmit={(event) => {
      event.preventDefault();
      resetPassword({
        variables: {
          token,
          input: { newPassword, newPasswordConfirmation }
        }
      });
    }}>
      <Form.Control
        name="email"
        type="email"
        autoComplete="username email"
        value={email || ''}
        className="d-none"
        readOnly
      />
      <Form.Group>
        <Form.Label>Password</Form.Label>
        <Form.Control
          name="newPassword"
          type="password"
          autoComplete="new-password"
          value={newPassword}
          onChange={(event) => setNewPassword(event.currentTarget.value)}
          isInvalid={errors.isInvalid('newPassword')}
        />
        <FormControlErrors attribute="newPassword" errors={errors} />
      </Form.Group>
      <Form.Group>
        <Form.Label>Password Confirmation</Form.Label>
        <Form.Control
          name="newPasswordConfirmation"
          type="password"
          autoComplete="new-password"
          value={newPasswordConfirmation}
          onChange={(event) => setNewPasswordConfirmation(event.currentTarget.value)}
          isInvalid={errors.isInvalid('newPasswordConfirmation')}
        />
        <FormControlErrors attribute="newPasswordConfirmation" errors={errors} />
      </Form.Group>
      <FormBaseErrors errors={errors} />
      <Form.Group className="text-right">
        <Button type="submit" disabled={loading}>Reset Password</Button>
      </Form.Group>
    </Form>
  );
};
