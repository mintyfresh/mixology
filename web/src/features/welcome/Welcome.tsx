import { gql, useQuery } from '@apollo/client';
import React from 'react';
import { RecipesSorting, SortedRecipesQuery, SortedRecipesQueryVariables } from '../../graphql/types';
import { RecipeShowcase, RECIPE_SHOWCASE_FRAGMENT } from './RecipeShowcase';

const SORTED_RECIPES_QUERY = gql`
  query SortedRecipes($sorting: RecipesSorting!) {
    recipes(sorting: $sorting, first: 9) {
      ...RecipeShowcase
    }
  }
  ${RECIPE_SHOWCASE_FRAGMENT}
`;

interface RecipeShowcaseFromQueryProps {
  title: string;
  sorting: RecipesSorting;
}

const RecipeShowcaseFromQuery: React.FC<RecipeShowcaseFromQueryProps> = ({ title, sorting }) => {
  const { data } = useQuery<SortedRecipesQuery, SortedRecipesQueryVariables>(SORTED_RECIPES_QUERY, {
    variables: { sorting }
  });

  if (!data?.recipes) {
    return null;
  }

  return (
    <RecipeShowcase title={title} recipes={data?.recipes} />
  );
};

export const Welcome: React.FC = () => {
  return (
    <div>
      <RecipeShowcaseFromQuery title="Highest Rated" sorting="HIGHEST_RATED" />
      <RecipeShowcaseFromQuery title="Most Popular" sorting="MOST_POPULAR" />
      <RecipeShowcaseFromQuery title="Latest" sorting="LATEST" />
    </div>
  );
};
