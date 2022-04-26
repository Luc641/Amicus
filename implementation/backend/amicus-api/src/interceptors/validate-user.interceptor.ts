import {
  /* inject, */
  injectable,
  Interceptor,
  InvocationContext,
  InvocationResult,
  Provider,
  ValueOrPromise,
} from '@loopback/core';
import {AppUser} from '../models';
import validator from 'validator';

/**
 * This class will be bound to the application as an `Interceptor` during
 * `boot`
 */
@injectable({tags: {key: ValidateUserInterceptor.BINDING_KEY}})
export class ValidateUserInterceptor implements Provider<Interceptor> {
  static readonly BINDING_KEY = `interceptors.${ValidateUserInterceptor.name}`;

  /*
  constructor() {}
  */

  /**
   * This method is used by LoopBack context to produce an interceptor function
   * for the binding.
   *
   * @returns An interceptor function
   */
  value() {
    return this.intercept.bind(this);
  }

  /**
   * The logic to intercept an invocation
   * @param invocationCtx - Invocation context
   * @param next - A function to invoke next interceptor or the target method
   */
  async intercept(
    invocationCtx: InvocationContext,
    next: () => ValueOrPromise<InvocationResult>,
  ) {
    console.log('log: before-', invocationCtx.methodName);
    let appUser: AppUser | undefined;
    if (invocationCtx.methodName === 'create')
      appUser = invocationCtx.args[0];

    if (appUser && !this.isUserValid(appUser)) {
      const err: ValidationError = new ValidationError(
        'Invalid user info',
      );
      err.statusCode = 422;
      throw err;
    }

    try {
      // Add pre-invocation logic here
      const result = await next();
      // Add post-invocation logic here
      return result;
    } catch (err) {
      // Add error handling logic here
      throw err;
    }
  }

  isUserValid(user: AppUser) {
    if (!validator.isEmail(user.email) || !validator.isAlpha(user.firstName)) {
      return false;
    }
    ;
    if (typeof user.lastName !== 'undefined' && user.lastName) {
      if (!validator.isAlpha(user.lastName))
        return false;
    }
    ;
    if (typeof user.birthDate !== 'undefined' && user.birthDate) {
      validator.isDate(user.birthDate);
    }
    ;
    return true;
  }
}

class ValidationError extends Error {
  code?: string;
  statusCode?: number;
}

