import { gql, useMutation } from '@apollo/client';
import React, { useState } from 'react';
import { Button, Form } from 'react-bootstrap';
import { useHistory } from 'react-router-dom';
import { SignInMutation, SignInMutationVariables } from '../../graphql/types';
import { CURRENT_SESSION_FRAGMENT, useCurrentSession } from '../../lib/current-session';
import { ValidationErrorsMap, VALIDATION_ERROR_FRAGMENT } from '../../lib/validation-errors-map';
import { FormBaseErrors } from '../errors/FormBaseErrors';
import { FormControlErrors } from '../errors/FormControlErrors';

const SIGN_IN_MUTATION = gql`
  mutation SignIn($input: SignInInput!) {
    signIn(input: $input) {
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

export const SignIn: React.FC = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const history = useHistory();
  const { setCurrentSession } = useCurrentSession();

  const [signIn, { data, loading }] = useMutation<SignInMutation, SignInMutationVariables>(SIGN_IN_MUTATION, {
    onCompleted: ({ signIn }) => {
      if (signIn?.session) {
        setCurrentSession(signIn.session);
        history.push('/');
      }
    }
  });

  const errors = ValidationErrorsMap.build(data?.signIn?.errors);

  return (
    <Form onSubmit={(event) => {
      event.preventDefault();
      signIn({
        variables: {
          input: {
            email,
            password
          }
        }
      });
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
      <FormBaseErrors errors={errors} />
      <Form.Group className="text-right">
        <Button type="submit" disabled={loading}>Sign In</Button>
      </Form.Group>
    </Form>
  );
};
