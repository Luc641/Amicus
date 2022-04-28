import {BindingKey} from "@loopback/core";
import {UserService} from "@loopback/authentication";
import {Credentials} from "@loopback/authentication-jwt/src/services/user.service";
import {AppUser} from "../models";

export namespace AppUserServiceBindings {
    export const USER_SERVICE = BindingKey.create<UserService<AppUser, Credentials>>(
        'services.app-user.service',
    );
}