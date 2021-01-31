import React from 'react';
import { NavDropdown } from 'react-bootstrap';
import { LinkContainer } from 'react-router-bootstrap';
import { SignOutItem } from './SignOutItem';

export interface UserDropdownProps {
  displayName: string;
}

export const UserDropdown: React.FC<UserDropdownProps> = ({ displayName }) => {
  return (
    <NavDropdown id="navbar-user-controls-dropdown" title={displayName} alignRight>
      <LinkContainer to="/my-recipes">
        <NavDropdown.Item>My Recipes</NavDropdown.Item>
      </LinkContainer>
      <NavDropdown.Divider />
      <LinkContainer to="/profile">
        <NavDropdown.Item>Profile</NavDropdown.Item>
      </LinkContainer>
      <LinkContainer to="/settings">
        <NavDropdown.Item>Settings</NavDropdown.Item>
      </LinkContainer>
      <LinkContainer to="/change-password">
        <NavDropdown.Item>Change Password</NavDropdown.Item>
      </LinkContainer>
      <NavDropdown.Divider />
      <SignOutItem />
    </NavDropdown>
  )
};
