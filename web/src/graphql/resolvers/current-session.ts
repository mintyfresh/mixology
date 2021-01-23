import { Resolver } from '@apollo/client';
import { getCurrentSessionExpiresAt, getCurrentSessionToken, isCurrentSessionExpired } from '../helpers/current-session';

export const currentSessionResolver: Resolver = () => {
  const token = getCurrentSessionToken();
  const expiresAt = getCurrentSessionExpiresAt();

  if (!token || !expiresAt) {
    return null;
  }

  return {
    token,
    expiresAt,
    isExpired: isCurrentSessionExpired()
  }
};
