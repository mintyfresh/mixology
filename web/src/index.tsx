import { ApolloProvider } from '@apollo/client';
import React from 'react';
import { Container } from 'react-bootstrap';
import ReactDOM from 'react-dom';
import { App } from './App';
import { AppNavbar } from './AppNavbar';
import { client } from './graphql/client';
import { reportWebVitals } from './reportWebVitals';

ReactDOM.render(
  <React.StrictMode>
    <ApolloProvider client={client}>
      <AppNavbar />
      <Container>
        <App />
      </Container>
    </ApolloProvider>
  </React.StrictMode>,
  document.getElementById('root')
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
