import React from 'react';
import { Container } from 'react-bootstrap';
import { Route, Switch } from 'react-router-dom';
import { AppNavbar } from './AppNavbar';
import { CreateRecipe } from './CreateRecipe';
import { MyRecipes } from './MyRecipes';

export const App: React.FC = () => {
  return (
    <>
      <AppNavbar />
      <Container>
        <Switch>
          <Route path="/my-recipes">
            <MyRecipes />
          </Route>
          <Route path="/recipes/new">
            <CreateRecipe />
          </Route>
          <Route path="/recipes/:id">
            Recipe
          </Route>
        </Switch>
      </Container>
    </>
  );
};
