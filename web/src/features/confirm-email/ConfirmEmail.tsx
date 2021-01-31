import { gql, useMutation } from '@apollo/client';
import { useEffect } from 'react';
import { Alert } from 'react-bootstrap';
import { Redirect } from 'react-router-dom';
import { ConfirmEmailMutation, ConfirmEmailMutationVariables } from '../../graphql/types';
import { useSearchParams } from '../../lib/use-search-params';
import { ValidationErrorsMap, VALIDATION_ERROR_FRAGMENT } from '../../lib/validation-errors-map';
import { FormBaseErrors } from '../errors/FormBaseErrors';

const CONFIRM_EMAIL_MUTATION = gql`
  mutation ConfirmEmail($token: String!) {
    confirmEmail(token: $token) {
      result
      errors {
        ...ValidationError
      }
    }
  }
  ${VALIDATION_ERROR_FRAGMENT}
`;

export const ConfirmEmail: React.FC = () => {
  const searchParams = useSearchParams();
  const token = searchParams.get('token');
  const [confirmEmail, { called, data }] = useMutation<ConfirmEmailMutation, ConfirmEmailMutationVariables>(CONFIRM_EMAIL_MUTATION);
  const errors = ValidationErrorsMap.build(data?.confirmEmail?.errors);

  useEffect(() => {
    if (token && !called) {
      confirmEmail({
        variables: { token }
      });
    }
  }, [token, called, confirmEmail]);

  if (!token) {
    return (
      <Redirect to="/" />
    );
  }

  if (!errors.empty) {
    return (
      <div>
        <p>We were unable to confirm your email.</p>
        <FormBaseErrors errors={errors} />
      </div>
    );
  }

  switch (data?.confirmEmail?.result)
  {
    case 'CONFIRMED':
      return (
        <Alert variant="success">
          Your email has been confirmed.
        </Alert>
      );

    case 'EXPIRED':
      return (
        <Alert variant="warning">
          This email confirmation link has expired.
        </Alert>
      );

    case 'STALE':
      return (
        <Alert variant="warning">
          The email address on your account has changed since this confirmation email was sent.
          <br />
          Please check your inbox (and spam folder) for a more recent email confirmation link.
        </Alert>
      );

    default:
      return null;
  }
};
