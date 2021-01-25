import { gql, useQuery } from '@apollo/client';
import { CurrentUserQuery } from '../graphql/types';

export type CurrentUser = NonNullable<CurrentUserQuery['currentUser']>;

const CURRENT_USER_QUERY = gql`
  query CurrentUser {
    currentUser {
      id
      displayName
    }
  }
`;

export const useCurrentUser = () => {
  const { data, loading } = useQuery<CurrentUserQuery>(CURRENT_USER_QUERY);

  return {
    loading,
    currentUser: data?.currentUser || null
  };
};
