import { CustomResponse } from '../responses/custom-response';

export function isAuth(allowedRoles: Array<String>, role: String): MethodDecorator {
    return function (target: any, propertyKey: String | Symbol, descriptor: PropertyDescriptor) {
        const originalMethod = descriptor.value;

        descriptor.value = function () {
            if(allowedRoles.includes(role)) {
                return originalMethod.apply(this);
            } else {
                throw new CustomResponse("Authentication Error", 401);
            }
        }
    }
}