import { gql, useMutation } from '@apollo/client';
import React from 'react';
import { Button, Container, Nav, Navbar } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { useHistory } from 'react-router-dom';
import { SignOutMutation } from '../../graphql/types';
import { useCurrentSession } from '../../lib/current-session';
import { useCurrentUser } from '../../lib/current-user';

const SIGN_OUT_MUTATION = gql`
  mutation SignOut {
    signOut {
      success
    }
  }
`;

const SignOutButton = () => {
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
    <Button variant="outline-danger" disabled={loading} onClick={() => signOut()}>Sign Out</Button>
  );
};

const UserControls = () => {
  const { currentUser, loading } = useCurrentUser();

  if (loading) {
    return null;
  }

  if (currentUser) {
    return (
      <>
        <SignOutButton />
      </>
    );
  } else {
    return (
      <>
        <LinkContainer to="/sign-in">
          <Button variant="secondary">Sign In</Button>
        </LinkContainer>
        <LinkContainer to="/sign-up">
          <Button variant="primary" className="ml-2">Sign Up</Button>
        </LinkContainer>
      </>
    )
  }
};

export const AppNavbar: React.FC = () => {
  return (
    <Navbar bg="dark" variant="dark" expand="md">
      <Container>
        <Navbar.Brand href="/">Mix</Navbar.Brand>
        <Navbar.Toggle aria-controls="app-navbar-collapse" />
        <Navbar.Collapse id="app-navbar-collapse">
          <Nav className="mr-auto">
            <Nav.Link href="/">Home</Nav.Link>
            <Nav.Link href="/my-recipes">My Recipes</Nav.Link>
          </Nav>
          <Nav>
            <UserControls />
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  )
};
