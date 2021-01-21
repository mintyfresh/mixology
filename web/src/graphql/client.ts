import { createHttpLink, ApolloClient, InMemoryCache } from '@apollo/client';

const httpLink = createHttpLink({
  uri: '/graphql'
});

export const client = new ApolloClient({
  link: httpLink,
  cache: new InMemoryCache()
});
