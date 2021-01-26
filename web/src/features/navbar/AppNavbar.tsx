import { gql, useMutation } from '@apollo/client';
import React from 'react';
import { Button, Container, Nav, Navbar, NavDropdown } from 'react-bootstrap';
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
    <NavDropdown.Item className="text-danger" disabled={loading} onClick={() => signOut()}>Sign Out</NavDropdown.Item>
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
        <NavDropdown id="navbar-user-controls-dropdown" title={currentUser.displayName} alignRight>
          <LinkContainer to="/my-recipes">
            <NavDropdown.Item>My Recipes</NavDropdown.Item>
          </LinkContainer>
          <LinkContainer to="/profile">
            <NavDropdown.Item>Profile</NavDropdown.Item>
          </LinkContainer>
          <LinkContainer to="/settings">
            <NavDropdown.Item>Settings</NavDropdown.Item>
          </LinkContainer>
          <NavDropdown.Divider />
          <SignOutButton />
        </NavDropdown>
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
            <LinkContainer to="/" exact>
              <Nav.Link>Home</Nav.Link>
            </LinkContainer>
          </Nav>
          <Nav>
            <UserControls />
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  )
};
