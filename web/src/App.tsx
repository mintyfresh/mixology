import React from 'react';
import { Container } from 'react-bootstrap';
import { Route, Switch } from 'react-router-dom';
import { AppNavbar } from './features/navbar/AppNavbar';
import { SignIn } from './features/auth/SignIn';
import { SignUp } from './features/auth/SignUp';
import { CreateRecipe } from './features/create-recipe/CreateRecipe';
import { MyRecipes } from './features/recipes/MyRecipes';
import { RecipeDetail } from './features/recipes/RecipeDetail';
import { ChangePassword } from './features/account/ChangePassword';
import { Welcome } from './features/welcome/Welcome';
import { ConfirmEmail } from './features/confirm-email/ConfirmEmail';
import { UpdateRecipe } from './features/create-recipe/UpdateRecipe';
import { ForgotPassword } from './features/auth/ForgotPassword';
import { ResetPassword } from './features/auth/ResetPassword';

export const App: React.FC = () => {
  return (
    <>
      <AppNavbar />
      <Container>
        <Switch>
          <Route path="/" exact>
            <Welcome />
          </Route>
          <Route path="/confirm-email" exact>
            <ConfirmEmail />
          </Route>
          <Route path="/my-recipes">
            <MyRecipes />
          </Route>
          <Route path="/change-password">
            <ChangePassword />
          </Route>
          <Route path="/recipes/new">
            <CreateRecipe />
          </Route>
          <Route path="/recipes/:slug" exact>
            <RecipeDetail />
          </Route>
          <Route path="/recipes/:slug/edit">
            <UpdateRecipe />
          </Route>
          <Route path="/sign-in">
            <SignIn />
          </Route>
          <Route path="/sign-up">
            <SignUp />
          </Route>
          <Route path="/forgot-password">
            <ForgotPassword />
          </Route>
          <Route path="/reset-password">
            <ResetPassword />
          </Route>
        </Switch>
      </Container>
    </>
  );
};
