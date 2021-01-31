import { useEffect } from 'react';
import { useHistory } from 'react-router-dom';

export const useCanonicalSlug = (currentPath?: string, canonicalPath?: string) => {
  const history = useHistory();

  return useEffect(() => {
    if (currentPath && canonicalPath && currentPath !== canonicalPath) {
      const location = history.location;

      location.pathname = location.pathname.replace(currentPath, canonicalPath);

      history.replace(location);
    }
  }, [history, currentPath, canonicalPath]);
};
