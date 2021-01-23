import React from 'react';
import { Container } from 'react-bootstrap';
import { Route, Switch } from 'react-router-dom';
import { AppNavbar } from './AppNavbar';
import { CreateRecipe } from './features/recipes/CreateRecipe';
import { MyRecipes } from './features/recipes/MyRecipes';
import { RecipeDetail } from './features/recipes/RecipeDetail';

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
            <RecipeDetail />
          </Route>
        </Switch>
      </Container>
    </>
  );
};
