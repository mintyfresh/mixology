import { gql, useMutation } from '@apollo/client';
import React, { useState } from 'react';
import { Button, Form } from 'react-bootstrap';
import { useHistory } from 'react-router-dom';
import { SignUpMutation, SignUpMutationVariables } from '../../graphql/types';
import { CURRENT_SESSION_FRAGMENT, useCurrentSession } from '../../lib/current-session';
import { ValidationErrorsMap, VALIDATION_ERROR_FRAGMENT } from '../../lib/validation-errors-map';
import { FormBaseErrors } from '../errors/FormBaseErrors';
import { FormControlErrors } from '../errors/FormControlErrors';

const SIGN_UP_MUTATION = gql`
  mutation SignUp($input: SignUpInput!) {
    signUp(input: $input) {
      user {
        id
      }
      session {
        ...CurrentSession
      }
      errors {
        ...ValidationError
      }
    }
  }
  ${CURRENT_SESSION_FRAGMENT}
  ${VALIDATION_ERROR_FRAGMENT}
`;

export const SignUp: React.FC = () => {
  const [email, setEmail] = useState('');
  const [displayName, setDisplayName] = useState('');
  const [password, setPassword] = useState('');
  const [passwordConfirmation, setPasswordConfirmation] = useState('');
  const [dateOfBirth, setDateOfBirth] = useState('');

  const history = useHistory();
  const { setCurrentSession } = useCurrentSession();

  const [signUp, { data, loading }] = useMutation<SignUpMutation, SignUpMutationVariables>(SIGN_UP_MUTATION, {
    variables: { input: { email, displayName, password, passwordConfirmation, dateOfBirth } },
    onCompleted: (data) => {
      if (data.signUp?.session) {
        setCurrentSession(data.signUp.session);

        history.push('/');
      }
    }
  });

  const errors = ValidationErrorsMap.build(data?.signUp?.errors);

  return (
    <Form onSubmit={(event) => {
      event.preventDefault();
      signUp();
    }}>
      <Form.Group>
        <Form.Label>Email</Form.Label>
        <Form.Control
          name="email"
          type="email"
          value={email}
          onChange={(event) => setEmail(event.currentTarget.value)}
          isInvalid={errors.isInvalid('email')}
        />
        <FormControlErrors attribute="email" errors={errors} />
      </Form.Group>
      <Form.Group>
        <Form.Label>Display Name</Form.Label>
        <Form.Control
          name="displayName"
          type="text"
          value={displayName}
          onChange={(event) => setDisplayName(event.currentTarget.value)}
          isInvalid={errors.isInvalid('displayName')}
        />
        <FormControlErrors attribute="displayName" errors={errors} />
      </Form.Group>
      <Form.Group>
        <Form.Label>Password</Form.Label>
        <Form.Control
          name="password"
          type="password"
          value={password}
          onChange={(event) => setPassword(event.currentTarget.value)}
          isInvalid={errors.isInvalid('password')}
        />
        <FormControlErrors attribute="password" errors={errors} />
      </Form.Group>
      <Form.Group>
        <Form.Label>Password Confirmation</Form.Label>
        <Form.Control
          name="passwordConfirmation"
          type="password"
          value={passwordConfirmation}
          onChange={(event) => setPasswordConfirmation(event.currentTarget.value)}
          isInvalid={errors.isInvalid('passwordConfirmation')}
        />
        <FormControlErrors attribute="passwordConfirmation" errors={errors} />
      </Form.Group>
      <Form.Group>
        <Form.Label>Date of Birth</Form.Label>
        <Form.Control
          name="dateOfBirth"
          type="date"
          value={dateOfBirth}
          onChange={(event) => setDateOfBirth(event.currentTarget.value)}
          isInvalid={errors.isInvalid('dateOfBirth')}
        />
        <FormControlErrors attribute="dateOfBirth" errors={errors} />
      </Form.Group>
      <FormBaseErrors errors={errors} />
      <Form.Group className="text-right">
        <Button type="submit" disabled={loading}>Sign Up</Button>
      </Form.Group>
    </Form>
  );
};
