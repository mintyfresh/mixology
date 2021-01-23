import { Resolver } from '@apollo/client';
import { setCurrentSession } from '../helpers/current-session';

export const setCurrentSessionResolver: Resolver = (_root, { currentSession }, { client }) => {
  setCurrentSession(currentSession);
  client.resetStore();

  return true;
};
