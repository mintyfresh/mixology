import { gql } from '@apollo/client';
import { ValidationError } from '../graphql/types';

export const VALIDATION_ERROR_FRAGMENT = gql`
  fragment ValidationError on ValidationError {
    attribute
    message(includeName: true)
  }
`;

export class ValidationErrorsMap {
  private _errors: { [attribute: string]: string[] };

  static build(errors?: ValidationError[] | null): ValidationErrorsMap {
    return new ValidationErrorsMap(errors || []);
  }

  constructor(errors: ValidationError[]) {
    this._errors = {};

    errors.forEach(({ attribute, message }) => {
      (this._errors[attribute] || (this._errors[attribute] = [])).push(message)
    });
  }

  base(): string[] {
    return this.on('base');
  }

  isValid(attribute: string): boolean {
    return !(this._errors[attribute]);
  }

  isInvalid(attribute: string): boolean {
    return !this.isValid(attribute);
  }

  on(attribute: string): string[] {
    return this._errors[attribute] || [];
  }
}
