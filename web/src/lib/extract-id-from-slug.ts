const SLUG_PATTERN = /^(?:.*-)*(\d+)$/;

export const extractIdFromSlug = (slug: string): string | null => {
  if (!slug) {
    return null;
  }

  const result = slug.match(SLUG_PATTERN);

  if (!result) {
    return null;
  }

  return result[1];
};
