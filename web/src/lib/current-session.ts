import { gql, useMutation, useQuery } from '@apollo/client';
import { CurrentSessionInput, CurrentSessionQuery, SetCurrentSessionMutation, SetCurrentSessionMutationVariables } from '../graphql/types';

export const CURRENT_SESSION_FRAGMENT = gql`
  fragment CurrentSession on UserSession {
    token
    expiresAt
  }
`;

const CURRENT_SESSION_QUERY = gql`
  query CurrentSession {
    currentSession @client {
      token
      expiresAt
    }
  }
`;

const SET_CURRENT_SESSION_MUTATION = gql`
  mutation SetCurrentSession($currentSession: CurrentSessionInput) {
    setCurrentSession(currentSession: $currentSession) @client
  }
`;

export const useCurrentSession = () => {
  const { data, loading }    = useQuery<CurrentSessionQuery>(CURRENT_SESSION_QUERY);
  const [setCurrentSession,] = useMutation<SetCurrentSessionMutation, SetCurrentSessionMutationVariables>(SET_CURRENT_SESSION_MUTATION);

  return {
    loading,
    currentSession: data?.currentSession || null,
    setCurrentSession: (currentSession: CurrentSessionInput | null) =>
      setCurrentSession({ variables: { currentSession } })
  };
};
