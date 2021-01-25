import React from 'react';
import { Button, Container, Nav, Navbar } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { useCurrentUser } from '../../lib/current-user';


const UserControls = () => {
  const { currentUser, loading } = useCurrentUser();

  if (loading) {
    return null;
  }

  if (currentUser) {
    return (
      <>
        <Button variant="outline-secondary">Sign Out</Button>
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
