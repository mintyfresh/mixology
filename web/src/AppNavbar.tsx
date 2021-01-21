import React from 'react';
import { Container, Nav, Navbar } from 'react-bootstrap';

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
        </Navbar.Collapse>
      </Container>
    </Navbar>
  )
};
