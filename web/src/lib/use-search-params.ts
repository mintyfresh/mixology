import { useLocation } from 'react-router';

export const useSearchParams = () => {
  const location = useLocation();

  return new URLSearchParams(location.search);
};
