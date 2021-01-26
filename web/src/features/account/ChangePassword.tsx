import { gql, useMutation } from '@apollo/client';
import React, { useState } from 'react';
import { Button, Form } from 'react-bootstrap';
import { ChangePasswordMutation, ChangePasswordMutationVariables } from '../../graphql/types';
import { ValidationErrorsMap, VALIDATION_ERROR_FRAGMENT } from '../../lib/validation-errors-map';
import { FormBaseErrors } from '../errors/FormBaseErrors';
import { FormControlErrors } from '../errors/FormControlErrors';

const CHANGE_PASSWORD_MUTATION = gql`
  mutation ChangePassword($input: ChangePasswordInput!) {
    changePassword(input: $input) {
      success
      errors {
        ...ValidationError
      }
    }
  }
  ${VALIDATION_ERROR_FRAGMENT}
`;

export const ChangePassword: React.FC = () => {
  const [oldPassword, setOldPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [newPasswordConfirmation, setNewPasswordConfirmation] = useState('');
  const [changePassword, { data, loading }] = useMutation<ChangePasswordMutation, ChangePasswordMutationVariables>(
    CHANGE_PASSWORD_MUTATION,
    {
      onCompleted: ({ changePassword }) => {
        if (changePassword?.success) {
          setOldPassword('');
          setNewPassword('');
          setNewPasswordConfirmation('');

          // TODO: Show success.
        }
      }
    }
  );
  const errors = ValidationErrorsMap.build(data?.changePassword?.errors);

  return (
    <Form onSubmit={(event) => {
      event.preventDefault();
      changePassword({
        variables: {
          input: {
            oldPassword,
            newPassword,
            newPasswordConfirmation
          }
        }
      });
    }}>
      <Form.Group>
        <Form.Label>Old Password</Form.Label>
        <Form.Control
          name="oldPassword"
          type="password"
          value={oldPassword}
          onChange={(event) => setOldPassword(event.currentTarget.value)}
          isInvalid={errors.isInvalid('oldPassword')}
        />
        <FormControlErrors attribute="oldPassword" errors={errors} />
      </Form.Group>
      <Form.Group>
        <Form.Label>New Password</Form.Label>
        <Form.Control
          name="newPassword"
          type="password"
          value={newPassword}
          onChange={(event) => setNewPassword(event.currentTarget.value)}
          isInvalid={errors.isInvalid('newPassword')}
        />
        <Form.Text muted>
          Your password must be 8 - 72 characters long, and may contain letters, numbers, spaces, and special characters.
        </Form.Text>
        <FormControlErrors attribute="newPassword" errors={errors} />
      </Form.Group>
      <Form.Group>
        <Form.Label>Confirm New Password</Form.Label>
        <Form.Control
          name="newPasswordConfirmation"
          type="password"
          value={newPasswordConfirmation}
          onChange={(event) => setNewPasswordConfirmation(event.currentTarget.value)}
          isInvalid={errors.isInvalid('newPasswordConfirmation')}
        />
        <FormControlErrors attribute="newPasswordConfirmation" errors={errors} />
      </Form.Group>
      <FormBaseErrors errors={errors} />
      <Form.Group className="text-right">
        <Button type="submit" disabled={loading}>Change Password</Button>
      </Form.Group>
    </Form>
  );
};
