export const newRecipePath = () =>
  `/recipes/new`
;

export const recipePath = (recipe: { slug: string }) =>
  `/recipes/${recipe.slug}`
;

export const editRecipePath = (recipe: { slug: string }) =>
  `/recipes/${recipe.slug}/edit`
;
