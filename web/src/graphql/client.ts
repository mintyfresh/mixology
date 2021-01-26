import { createHttpLink, ApolloClient, InMemoryCache } from '@apollo/client';
import { setContext } from '@apollo/client/link/context';
import { loader } from 'graphql.macro';
import { getCurrentSessionToken } from './helpers/current-session';
import { currentSessionResolver } from './resolvers/current-session';
import { setCurrentSessionResolver } from './resolvers/set-current-session';

const httpLink = createHttpLink({
  uri: '/graphql'
});

const authLink = setContext((_, { headers }) => {
  const extra: { [key: string]: string } = {};
  const token = getCurrentSessionToken();

  if (token) {
    extra['Authorization'] = `Session ${token}`;
  }

  return {
    headers: {
      ...headers,
      ...extra
    }
  };
});

export const client = new ApolloClient({
  link: authLink.concat(httpLink),
  cache: new InMemoryCache(),
  typeDefs: loader('./client-schema.graphql'),
  resolvers: {
    Query: {
      currentSession: currentSessionResolver
    },
    Mutation: {
      setCurrentSession: setCurrentSessionResolver
    }
  }
});
