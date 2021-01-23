import { CurrentSessionFragment } from '../types';

const CURRENT_SESSION_TOKEN = 'current-session-token';
const CURRENT_SESSION_EXPIRES_AT = 'current-session-expires-at';

export function getCurrentSessionToken(): string | null {
  return localStorage.getItem(CURRENT_SESSION_TOKEN);
};

export function getCurrentSessionExpiresAt(): string | null {
  return localStorage.getItem(CURRENT_SESSION_EXPIRES_AT);
};

export function isCurrentSessionExpired(): boolean {
  const expiresAt = getCurrentSessionExpiresAt();

  return !expiresAt || new Date(expiresAt) < new Date();
};

export function setCurrentSession(session: CurrentSessionFragment | null): void {
  if (session) {
    localStorage.setItem(CURRENT_SESSION_TOKEN, session.token);
    localStorage.setItem(CURRENT_SESSION_EXPIRES_AT, session.expiresAt);
  } else {
    localStorage.removeItem(CURRENT_SESSION_TOKEN);
    localStorage.removeItem(CURRENT_SESSION_EXPIRES_AT);
  }
};
