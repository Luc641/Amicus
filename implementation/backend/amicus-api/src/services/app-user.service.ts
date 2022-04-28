import {UserService} from '@loopback/authentication';
import {repository} from '@loopback/repository';
import {HttpErrors} from '@loopback/rest';
import {securityId, UserProfile} from '@loopback/security';
import {compare} from 'bcryptjs';
import {AppUser} from '../models';
import {AppUserRepository} from '../repositories';

export type Credentials = {
    email: string;
    password: string;
};

export class AppUserService implements UserService<AppUser, Credentials> {
    constructor(
        @repository(AppUserRepository) public userRepository: AppUserRepository,
    ) {}

    async verifyCredentials(credentials: Credentials): Promise<AppUser> {
        const invalidCredentialsError = 'Invalid email or password.';

        const foundUser = await this.userRepository.findOne({
            where: {email: credentials.email},
        });
        if (!foundUser) {
            throw new HttpErrors.Unauthorized(invalidCredentialsError);
        }

        const credentialsFound = await this.userRepository.findCredentials(
            foundUser.id,
        );
        if (!credentialsFound) {
            throw new HttpErrors.Unauthorized(invalidCredentialsError);
        }

        const passwordMatched = await compare(
            credentials.password,
            credentialsFound.password,
        );

        if (!passwordMatched) {
            throw new HttpErrors.Unauthorized(invalidCredentialsError);
        }

        return foundUser;
    }

    convertToUserProfile(user: AppUser): UserProfile {
        return {
            [securityId]: user.id.toString(),
            name: user.username,
            id: user.id,
            email: user.email,
        };
    }
}