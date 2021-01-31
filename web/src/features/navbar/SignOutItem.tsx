import { gql, useMutation } from '@apollo/client';
import { NavDropdown } from 'react-bootstrap';
import { useHistory } from 'react-router-dom';
import { SignOutMutation } from '../../graphql/types';
import { useCurrentSession } from '../../lib/current-session';

const SIGN_OUT_MUTATION = gql`
  mutation SignOut {
    signOut {
      success
    }
  }
`;

export const SignOutItem = () => {
  const history = useHistory();
  const { setCurrentSession } = useCurrentSession();
  const [signOut, { loading }] = useMutation<SignOutMutation>(SIGN_OUT_MUTATION, {
    onCompleted: ({ signOut }) => {
      if (signOut?.success) {
        setCurrentSession(null);
        history.push('/');
      }
    }
  });

  return (
    <NavDropdown.Item className="text-danger" disabled={loading} onClick={() => signOut()}>Sign Out</NavDropdown.Item>
  );
};
