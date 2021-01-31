export type Maybe<T> = T | null;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string | number;
  String: string;
  Boolean: boolean;
  Int: number;
  Float: number;
  /** An ISO 8601-encoded date */
  ISO8601Date: string;
  /** An ISO 8601-encoded datetime */
  ISO8601DateTime: string;
};

/** Autogenerated return type of AddFavouriteRecipeMutation */
export type AddFavouriteRecipeMutationPayload = {
  __typename?: 'AddFavouriteRecipeMutationPayload';
  errors?: Maybe<Array<ValidationError>>;
  recipe?: Maybe<Recipe>;
};

export type ChangePasswordInput = {
  oldPassword: Scalars['String'];
  newPassword: Scalars['String'];
  newPasswordConfirmation: Scalars['String'];
};

/** Autogenerated return type of ChangePasswordMutation */
export type ChangePasswordMutationPayload = {
  __typename?: 'ChangePasswordMutationPayload';
  errors?: Maybe<Array<ValidationError>>;
  success?: Maybe<Scalars['Boolean']>;
};

/** Autogenerated return type of ConfirmEmailMutation */
export type ConfirmEmailMutationPayload = {
  __typename?: 'ConfirmEmailMutationPayload';
  errors?: Maybe<Array<ValidationError>>;
  result?: Maybe<ConfirmEmailResult>;
};

export type ConfirmEmailResult = 
  | 'CONFIRMED'
  | 'EXPIRED'
  | 'STALE';

/** Autogenerated return type of CreateRecipeMutation */
export type CreateRecipeMutationPayload = {
  __typename?: 'CreateRecipeMutationPayload';
  errors?: Maybe<Array<ValidationError>>;
  recipe?: Maybe<Recipe>;
};

export type CreateReportInput = {
  message: Scalars['String'];
};

export type CreateReviewInput = {
  body: Scalars['String'];
  rating: Scalars['Int'];
};

/** Autogenerated return type of CreateReviewMutation */
export type CreateReviewMutationPayload = {
  __typename?: 'CreateReviewMutationPayload';
  errors?: Maybe<Array<ValidationError>>;
  recipe?: Maybe<Recipe>;
  review?: Maybe<Review>;
};

/** Autogenerated return type of DeleteRecipeMutation */
export type DeleteRecipeMutationPayload = {
  __typename?: 'DeleteRecipeMutationPayload';
  errors?: Maybe<Array<ValidationError>>;
  success?: Maybe<Scalars['Boolean']>;
};

export type Favouriteable = {
  favouritesCount: Scalars['Int'];
  isFavourite: Scalars['Boolean'];
};



export type Mutation = {
  __typename?: 'Mutation';
  addFavouriteRecipe?: Maybe<AddFavouriteRecipeMutationPayload>;
  changePassword?: Maybe<ChangePasswordMutationPayload>;
  confirmEmail?: Maybe<ConfirmEmailMutationPayload>;
  createRecipe?: Maybe<CreateRecipeMutationPayload>;
  createReview?: Maybe<CreateReviewMutationPayload>;
  deleteRecipe?: Maybe<DeleteRecipeMutationPayload>;
  performPasswordReset?: Maybe<PerformPasswordResetMutationPayload>;
  removeFavouriteRecipe?: Maybe<RemoveFavouriteRecipeMutationPayload>;
  reportRecipe?: Maybe<ReportRecipeMutationPayload>;
  reportReview?: Maybe<ReportReviewMutationPayload>;
  requestPasswordReset?: Maybe<RequestPasswordResetMutationPayload>;
  setCurrentSession?: Maybe<Scalars['Boolean']>;
  signIn?: Maybe<SignInMutationPayload>;
  signOut?: Maybe<SignOutMutationPayload>;
  signUp?: Maybe<SignUpMutationPayload>;
  updateRecipe?: Maybe<UpdateRecipeMutationPayload>;
};


export type MutationAddFavouriteRecipeArgs = {
  id: Scalars['ID'];
};


export type MutationChangePasswordArgs = {
  input: ChangePasswordInput;
};


export type MutationConfirmEmailArgs = {
  token: Scalars['String'];
};


export type MutationCreateRecipeArgs = {
  input: RecipeInput;
};


export type MutationCreateReviewArgs = {
  recipeId: Scalars['ID'];
  input: CreateReviewInput;
};


export type MutationDeleteRecipeArgs = {
  id: Scalars['ID'];
};


export type MutationPerformPasswordResetArgs = {
  token: Scalars['String'];
  input: PerformPasswordResetInput;
};


export type MutationRemoveFavouriteRecipeArgs = {
  id: Scalars['ID'];
};


export type MutationReportRecipeArgs = {
  recipeId: Scalars['ID'];
  input: CreateReportInput;
};


export type MutationReportReviewArgs = {
  reviewId: Scalars['ID'];
  input: CreateReportInput;
};


export type MutationRequestPasswordResetArgs = {
  email: Scalars['String'];
};


export type MutationSetCurrentSessionArgs = {
  currentSession?: Maybe<CurrentSessionInput>;
};


export type MutationSignInArgs = {
  input: SignInInput;
};


export type MutationSignUpArgs = {
  input: SignUpInput;
};


export type MutationUpdateRecipeArgs = {
  id: Scalars['ID'];
  input: RecipeInput;
};

/** Information about pagination in a connection. */
export type PageInfo = {
  __typename?: 'PageInfo';
  /** When paginating forwards, the cursor to continue. */
  endCursor?: Maybe<Scalars['String']>;
  /** When paginating forwards, are there more items? */
  hasNextPage: Scalars['Boolean'];
  /** When paginating backwards, are there more items? */
  hasPreviousPage: Scalars['Boolean'];
  /** When paginating backwards, the cursor to continue. */
  startCursor?: Maybe<Scalars['String']>;
};

export type PasswordReset = {
  __typename?: 'PasswordReset';
  email: Scalars['String'];
  expired: Scalars['Boolean'];
};

export type PerformPasswordResetInput = {
  newPassword: Scalars['String'];
  newPasswordConfirmation: Scalars['String'];
};

/** Autogenerated return type of PerformPasswordResetMutation */
export type PerformPasswordResetMutationPayload = {
  __typename?: 'PerformPasswordResetMutationPayload';
  errors?: Maybe<Array<ValidationError>>;
  success?: Maybe<Scalars['Boolean']>;
};

export type Query = {
  __typename?: 'Query';
  currentSession?: Maybe<CurrentSession>;
  currentUser?: Maybe<User>;
  passwordReset: PasswordReset;
  recipe: Recipe;
  recipes: RecipeConnection;
};


export type QueryPasswordResetArgs = {
  token: Scalars['String'];
};


export type QueryRecipeArgs = {
  id: Scalars['ID'];
};


export type QueryRecipesArgs = {
  sorting?: Maybe<RecipesSorting>;
  after?: Maybe<Scalars['String']>;
  before?: Maybe<Scalars['String']>;
  first?: Maybe<Scalars['Int']>;
  last?: Maybe<Scalars['Int']>;
};

export type Recipe = Favouriteable & {
  __typename?: 'Recipe';
  author: User;
  averageRating: Scalars['Float'];
  description: Scalars['String'];
  equipments: Array<RecipeEquipment>;
  favouritesCount: Scalars['Int'];
  id: Scalars['ID'];
  imageUrl?: Maybe<Scalars['String']>;
  ingredients: Array<RecipeIngredient>;
  isFavourite: Scalars['Boolean'];
  name: Scalars['String'];
  permissions: RecipePermissions;
  reviews: ReviewConnection;
  reviewsCount: Scalars['Int'];
  slug: Scalars['String'];
  steps: Array<RecipeStep>;
};


export type RecipeImageUrlArgs = {
  usePlaceholder?: Maybe<Scalars['Boolean']>;
};


export type RecipeReviewsArgs = {
  after?: Maybe<Scalars['String']>;
  before?: Maybe<Scalars['String']>;
  first?: Maybe<Scalars['Int']>;
  last?: Maybe<Scalars['Int']>;
};

/** The connection type for Recipe. */
export type RecipeConnection = {
  __typename?: 'RecipeConnection';
  /** A list of edges. */
  edges: Array<RecipeEdge>;
  /** A list of nodes. */
  nodes: Array<Recipe>;
  /** Information to aid in pagination. */
  pageInfo: PageInfo;
};

/** An edge in a connection. */
export type RecipeEdge = {
  __typename?: 'RecipeEdge';
  /** A cursor for use in pagination. */
  cursor: Scalars['String'];
  /** The item at the end of the edge. */
  node: Recipe;
};

export type RecipeEquipment = {
  __typename?: 'RecipeEquipment';
  id: Scalars['ID'];
  name: Scalars['String'];
  quantity?: Maybe<Scalars['Int']>;
};

export type RecipeEquipmentInput = {
  name: Scalars['String'];
  quantity?: Maybe<Scalars['Int']>;
};

export type RecipeIngredient = {
  __typename?: 'RecipeIngredient';
  id: Scalars['ID'];
  name: Scalars['String'];
  optional: Scalars['Boolean'];
  quantity?: Maybe<Scalars['String']>;
  quantityAmount?: Maybe<Scalars['Float']>;
  quantityUnit?: Maybe<Scalars['String']>;
};

export type RecipeIngredientInput = {
  name: Scalars['String'];
  quantityAmount?: Maybe<Scalars['Float']>;
  quantityUnit?: Maybe<Scalars['String']>;
  optional: Scalars['Boolean'];
};

export type RecipeInput = {
  name: Scalars['String'];
  description?: Maybe<Scalars['String']>;
  ingredients?: Maybe<Array<RecipeIngredientInput>>;
  equipments?: Maybe<Array<RecipeEquipmentInput>>;
  steps?: Maybe<Array<Scalars['String']>>;
};

/** Permissions granted to the current user for this Recipe. */
export type RecipePermissions = {
  __typename?: 'RecipePermissions';
  /** Indicates whether the current user can `delete` this object. */
  canDelete: Scalars['Boolean'];
  /** Indicates whether the current user can `favourite` this object. */
  canFavourite: Scalars['Boolean'];
  /** Indicates whether the current user can `review` this object. */
  canReview: Scalars['Boolean'];
  /** Indicates whether the current user can `update` this object. */
  canUpdate: Scalars['Boolean'];
};

export type RecipeStep = {
  __typename?: 'RecipeStep';
  body: Scalars['String'];
  id: Scalars['ID'];
};

export type RecipesSorting = 
  | 'DEFAULT'
  | 'LATEST'
  | 'MOST_POPULAR'
  | 'HIGHEST_RATED';

/** Autogenerated return type of RemoveFavouriteRecipeMutation */
export type RemoveFavouriteRecipeMutationPayload = {
  __typename?: 'RemoveFavouriteRecipeMutationPayload';
  errors?: Maybe<Array<ValidationError>>;
  recipe?: Maybe<Recipe>;
};

/** Autogenerated return type of ReportRecipeMutation */
export type ReportRecipeMutationPayload = {
  __typename?: 'ReportRecipeMutationPayload';
  errors?: Maybe<Array<ValidationError>>;
  success?: Maybe<Scalars['Boolean']>;
};

/** Autogenerated return type of ReportReviewMutation */
export type ReportReviewMutationPayload = {
  __typename?: 'ReportReviewMutationPayload';
  errors?: Maybe<Array<ValidationError>>;
  success?: Maybe<Scalars['Boolean']>;
};

/** Autogenerated return type of RequestPasswordResetMutation */
export type RequestPasswordResetMutationPayload = {
  __typename?: 'RequestPasswordResetMutationPayload';
  errors?: Maybe<Array<ValidationError>>;
  success?: Maybe<Scalars['Boolean']>;
};

export type Review = {
  __typename?: 'Review';
  author: User;
  body: Scalars['String'];
  id: Scalars['ID'];
  rating: Scalars['Int'];
};

/** The connection type for Review. */
export type ReviewConnection = {
  __typename?: 'ReviewConnection';
  /** A list of edges. */
  edges: Array<ReviewEdge>;
  /** A list of nodes. */
  nodes: Array<Review>;
  /** Information to aid in pagination. */
  pageInfo: PageInfo;
};

/** An edge in a connection. */
export type ReviewEdge = {
  __typename?: 'ReviewEdge';
  /** A cursor for use in pagination. */
  cursor: Scalars['String'];
  /** The item at the end of the edge. */
  node: Review;
};

export type SignInInput = {
  email: Scalars['String'];
  password: Scalars['String'];
};

/** Autogenerated return type of SignInMutation */
export type SignInMutationPayload = {
  __typename?: 'SignInMutationPayload';
  errors?: Maybe<Array<ValidationError>>;
  session?: Maybe<UserSession>;
  user?: Maybe<User>;
};

/** Autogenerated return type of SignOutMutation */
export type SignOutMutationPayload = {
  __typename?: 'SignOutMutationPayload';
  success?: Maybe<Scalars['Boolean']>;
};

export type SignUpInput = {
  email: Scalars['String'];
  displayName: Scalars['String'];
  password: Scalars['String'];
  passwordConfirmation: Scalars['String'];
  dateOfBirth: Scalars['ISO8601Date'];
};

/** Autogenerated return type of SignUpMutation */
export type SignUpMutationPayload = {
  __typename?: 'SignUpMutationPayload';
  errors?: Maybe<Array<ValidationError>>;
  session?: Maybe<UserSession>;
  user?: Maybe<User>;
};

/** Autogenerated return type of UpdateRecipeMutation */
export type UpdateRecipeMutationPayload = {
  __typename?: 'UpdateRecipeMutationPayload';
  errors?: Maybe<Array<ValidationError>>;
  recipe?: Maybe<Recipe>;
};

export type User = {
  __typename?: 'User';
  authoredRecipes: RecipeConnection;
  createdAt: Scalars['ISO8601DateTime'];
  displayName: Scalars['String'];
  favouritedRecipes: RecipeConnection;
  id: Scalars['ID'];
};


export type UserAuthoredRecipesArgs = {
  after?: Maybe<Scalars['String']>;
  before?: Maybe<Scalars['String']>;
  first?: Maybe<Scalars['Int']>;
  last?: Maybe<Scalars['Int']>;
};


export type UserFavouritedRecipesArgs = {
  after?: Maybe<Scalars['String']>;
  before?: Maybe<Scalars['String']>;
  first?: Maybe<Scalars['Int']>;
  last?: Maybe<Scalars['Int']>;
};

export type UserSession = {
  __typename?: 'UserSession';
  expiresAt: Scalars['ISO8601DateTime'];
  token: Scalars['String'];
};

export type ValidationError = {
  __typename?: 'ValidationError';
  attribute: Scalars['String'];
  message: Scalars['String'];
};


export type ValidationErrorMessageArgs = {
  includeName?: Maybe<Scalars['Boolean']>;
};

export type CurrentSession = {
  __typename?: 'CurrentSession';
  token: Scalars['String'];
  expiresAt: Scalars['ISO8601DateTime'];
};

export type CurrentSessionInput = {
  token: Scalars['String'];
  expiresAt: Scalars['ISO8601DateTime'];
};

export type ChangePasswordMutationVariables = Exact<{
  input: ChangePasswordInput;
}>;


export type ChangePasswordMutation = (
  { __typename?: 'Mutation' }
  & { changePassword?: Maybe<(
    { __typename?: 'ChangePasswordMutationPayload' }
    & Pick<ChangePasswordMutationPayload, 'success'>
    & { errors?: Maybe<Array<(
      { __typename?: 'ValidationError' }
      & ValidationErrorFragment
    )>> }
  )> }
);

export type RequestPasswordResetMutationVariables = Exact<{
  email: Scalars['String'];
}>;


export type RequestPasswordResetMutation = (
  { __typename?: 'Mutation' }
  & { requestPasswordReset?: Maybe<(
    { __typename?: 'RequestPasswordResetMutationPayload' }
    & Pick<RequestPasswordResetMutationPayload, 'success'>
    & { errors?: Maybe<Array<(
      { __typename?: 'ValidationError' }
      & ValidationErrorFragment
    )>> }
  )> }
);

export type PasswordResetQueryVariables = Exact<{
  token: Scalars['String'];
}>;


export type PasswordResetQuery = (
  { __typename?: 'Query' }
  & { passwordReset: (
    { __typename?: 'PasswordReset' }
    & Pick<PasswordReset, 'email' | 'expired'>
  ) }
);

export type ResetPasswordMutationVariables = Exact<{
  token: Scalars['String'];
  input: PerformPasswordResetInput;
}>;


export type ResetPasswordMutation = (
  { __typename?: 'Mutation' }
  & { performPasswordReset?: Maybe<(
    { __typename?: 'PerformPasswordResetMutationPayload' }
    & Pick<PerformPasswordResetMutationPayload, 'success'>
    & { errors?: Maybe<Array<(
      { __typename?: 'ValidationError' }
      & ValidationErrorFragment
    )>> }
  )> }
);

export type SignInMutationVariables = Exact<{
  input: SignInInput;
}>;


export type SignInMutation = (
  { __typename?: 'Mutation' }
  & { signIn?: Maybe<(
    { __typename?: 'SignInMutationPayload' }
    & { user?: Maybe<(
      { __typename?: 'User' }
      & Pick<User, 'id'>
    )>, session?: Maybe<(
      { __typename?: 'UserSession' }
      & CurrentSessionFragment
    )>, errors?: Maybe<Array<(
      { __typename?: 'ValidationError' }
      & ValidationErrorFragment
    )>> }
  )> }
);

export type SignUpMutationVariables = Exact<{
  input: SignUpInput;
}>;


export type SignUpMutation = (
  { __typename?: 'Mutation' }
  & { signUp?: Maybe<(
    { __typename?: 'SignUpMutationPayload' }
    & { user?: Maybe<(
      { __typename?: 'User' }
      & Pick<User, 'id'>
    )>, session?: Maybe<(
      { __typename?: 'UserSession' }
      & CurrentSessionFragment
    )>, errors?: Maybe<Array<(
      { __typename?: 'ValidationError' }
      & ValidationErrorFragment
    )>> }
  )> }
);

export type ConfirmEmailMutationVariables = Exact<{
  token: Scalars['String'];
}>;


export type ConfirmEmailMutation = (
  { __typename?: 'Mutation' }
  & { confirmEmail?: Maybe<(
    { __typename?: 'ConfirmEmailMutationPayload' }
    & Pick<ConfirmEmailMutationPayload, 'result'>
    & { errors?: Maybe<Array<(
      { __typename?: 'ValidationError' }
      & ValidationErrorFragment
    )>> }
  )> }
);

export type CreateRecipeMutationVariables = Exact<{
  input: RecipeInput;
}>;


export type CreateRecipeMutation = (
  { __typename?: 'Mutation' }
  & { createRecipe?: Maybe<(
    { __typename?: 'CreateRecipeMutationPayload' }
    & { recipe?: Maybe<(
      { __typename?: 'Recipe' }
      & Pick<Recipe, 'id' | 'name' | 'slug' | 'description'>
      & { steps: Array<(
        { __typename?: 'RecipeStep' }
        & Pick<RecipeStep, 'id' | 'body'>
      )> }
    )>, errors?: Maybe<Array<(
      { __typename?: 'ValidationError' }
      & Pick<ValidationError, 'attribute' | 'message'>
    )>> }
  )> }
);

export type RecipeForUpdateQueryVariables = Exact<{
  id: Scalars['ID'];
}>;


export type RecipeForUpdateQuery = (
  { __typename?: 'Query' }
  & { recipe: (
    { __typename?: 'Recipe' }
    & Pick<Recipe, 'id' | 'name' | 'slug' | 'description'>
    & { steps: Array<(
      { __typename?: 'RecipeStep' }
      & Pick<RecipeStep, 'body'>
    )> }
  ) }
);

export type UpdateRecipeMutationVariables = Exact<{
  id: Scalars['ID'];
  input: RecipeInput;
}>;


export type UpdateRecipeMutation = (
  { __typename?: 'Mutation' }
  & { updateRecipe?: Maybe<(
    { __typename?: 'UpdateRecipeMutationPayload' }
    & { recipe?: Maybe<(
      { __typename?: 'Recipe' }
      & Pick<Recipe, 'id' | 'slug'>
    )>, errors?: Maybe<Array<(
      { __typename?: 'ValidationError' }
      & ValidationErrorFragment
    )>> }
  )> }
);

export type SignOutMutationVariables = Exact<{ [key: string]: never; }>;


export type SignOutMutation = (
  { __typename?: 'Mutation' }
  & { signOut?: Maybe<(
    { __typename?: 'SignOutMutationPayload' }
    & Pick<SignOutMutationPayload, 'success'>
  )> }
);

export type MyRecipesQueryVariables = Exact<{ [key: string]: never; }>;


export type MyRecipesQuery = (
  { __typename?: 'Query' }
  & { currentUser?: Maybe<(
    { __typename?: 'User' }
    & Pick<User, 'id'>
    & { authoredRecipes: (
      { __typename?: 'RecipeConnection' }
      & { nodes: Array<(
        { __typename?: 'Recipe' }
        & Pick<Recipe, 'id' | 'name' | 'slug' | 'description'>
      )> }
    ) }
  )> }
);

export type DeleteRecipeMutationVariables = Exact<{
  id: Scalars['ID'];
}>;


export type DeleteRecipeMutation = (
  { __typename?: 'Mutation' }
  & { deleteRecipe?: Maybe<(
    { __typename?: 'DeleteRecipeMutationPayload' }
    & Pick<DeleteRecipeMutationPayload, 'success'>
  )> }
);

export type RecipeControlsFragment = (
  { __typename?: 'Recipe' }
  & Pick<Recipe, 'id' | 'slug'>
  & { permissions: (
    { __typename?: 'RecipePermissions' }
    & Pick<RecipePermissions, 'canUpdate' | 'canDelete'>
  ) }
);

export type RecipeDetailQueryVariables = Exact<{
  id: Scalars['ID'];
}>;


export type RecipeDetailQuery = (
  { __typename?: 'Query' }
  & { recipe: (
    { __typename?: 'Recipe' }
    & Pick<Recipe, 'id' | 'name' | 'description'>
    & { steps: Array<(
      { __typename?: 'RecipeStep' }
      & Pick<RecipeStep, 'id' | 'body'>
    )>, reviews: (
      { __typename?: 'ReviewConnection' }
      & { nodes: Array<(
        { __typename?: 'Review' }
        & Pick<Review, 'id' | 'body' | 'rating'>
        & { author: (
          { __typename?: 'User' }
          & Pick<User, 'id' | 'displayName'>
        ) }
      )>, pageInfo: (
        { __typename?: 'PageInfo' }
        & Pick<PageInfo, 'hasNextPage' | 'endCursor'>
      ) }
    ) }
    & RecipeControlsFragment
    & RecipeIngredientsFragment
    & RecipeEquipmentsFragment
  ) }
);

export type RecipeEquipmentsFragment = (
  { __typename?: 'Recipe' }
  & { equipments: Array<(
    { __typename?: 'RecipeEquipment' }
    & Pick<RecipeEquipment, 'id' | 'name' | 'quantity'>
  )> }
);

export type RecipeIngredientsFragment = (
  { __typename?: 'Recipe' }
  & { ingredients: Array<(
    { __typename?: 'RecipeIngredient' }
    & Pick<RecipeIngredient, 'id' | 'name' | 'quantity'>
  )> }
);

export type RecipeCardFragment = (
  { __typename?: 'Recipe' }
  & Pick<Recipe, 'id' | 'name' | 'slug' | 'imageUrl' | 'averageRating' | 'reviewsCount'>
  & { author: (
    { __typename?: 'User' }
    & Pick<User, 'id' | 'displayName'>
  ) }
);

export type RecipeShowcaseFragment = (
  { __typename?: 'RecipeConnection' }
  & { nodes: Array<(
    { __typename?: 'Recipe' }
    & RecipeCardFragment
  )>, pageInfo: (
    { __typename?: 'PageInfo' }
    & Pick<PageInfo, 'hasNextPage' | 'endCursor'>
  ) }
);

export type SortedRecipesQueryVariables = Exact<{
  sorting: RecipesSorting;
}>;


export type SortedRecipesQuery = (
  { __typename?: 'Query' }
  & { recipes: (
    { __typename?: 'RecipeConnection' }
    & RecipeShowcaseFragment
  ) }
);

export type CurrentSessionFragment = (
  { __typename?: 'UserSession' }
  & Pick<UserSession, 'token' | 'expiresAt'>
);

export type CurrentSessionQueryVariables = Exact<{ [key: string]: never; }>;


export type CurrentSessionQuery = (
  { __typename?: 'Query' }
  & { currentSession?: Maybe<(
    { __typename?: 'CurrentSession' }
    & Pick<CurrentSession, 'token' | 'expiresAt'>
  )> }
);

export type SetCurrentSessionMutationVariables = Exact<{
  currentSession?: Maybe<CurrentSessionInput>;
}>;


export type SetCurrentSessionMutation = (
  { __typename?: 'Mutation' }
  & Pick<Mutation, 'setCurrentSession'>
);

export type CurrentUserQueryVariables = Exact<{ [key: string]: never; }>;


export type CurrentUserQuery = (
  { __typename?: 'Query' }
  & { currentUser?: Maybe<(
    { __typename?: 'User' }
    & Pick<User, 'id' | 'displayName'>
  )> }
);

export type ValidationErrorFragment = (
  { __typename?: 'ValidationError' }
  & Pick<ValidationError, 'attribute' | 'message'>
);
