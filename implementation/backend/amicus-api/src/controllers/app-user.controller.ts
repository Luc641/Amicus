import {Count, CountSchema, Filter, FilterExcludingWhere, repository, Where} from '@loopback/repository';
import {
    del,
    get,
    getModelSchemaRef,
    param,
    patch,
    post,
    put,
    requestBody,
    response,
    SchemaObject,
} from '@loopback/rest';
import {AppUser, ExpertCategory} from '../models';
import {
    AppUserRepository,
    ExpertCategoryRepository,
    MediaRepository,
} from '../repositories';
import {genSalt, hash} from 'bcryptjs';

import {inject, intercept} from '@loopback/core';
import {ValidateUserInterceptor} from '../interceptors';
import {TokenServiceBindings} from '@loopback/authentication-jwt';
import {authenticate, TokenService} from '@loopback/authentication';
import {SecurityBindings, securityId, UserProfile} from '@loopback/security';
import {AppUserService, Credentials} from '../services/app-user.service';
import {AppUserServiceBindings} from '../bindings/app-user-service.bindings';

import {CustomResponse} from '../responses/custom-response';


// Describe the schema of user credentials
const CredentialsSchema: SchemaObject = {
    type: 'object',
    required: ['email', 'password'],
    properties: {
        email: {
            type: 'string',
            format: 'email',
        },
        password: {
            type: 'string',
            minLength: 8,
        },
    },
};

export const CredentialsRequestBody = {
    description: 'The input of the login function',
    required: true,
    content: {
        'application/json': {schema: CredentialsSchema},
    },
};

export class AppUserController {
    constructor(
        @inject(TokenServiceBindings.TOKEN_SERVICE)
        public jwtService: TokenService,
        @inject(AppUserServiceBindings.USER_SERVICE)
        public userService: AppUserService,
        @inject(SecurityBindings.USER, {optional: true})
        public user: UserProfile,
        @repository(AppUserRepository)
        public appUserRepository: AppUserRepository,
        @repository(MediaRepository)
        public mediaRepository: MediaRepository,
        @repository(ExpertCategoryRepository)
        protected expertCategoryRepository: ExpertCategoryRepository,
    ) {
    }

    // Endpoint used to log in the app
    @post('/users/login')
    @response(200, {
        description: 'Logged in Token',
        content: {
            'application/json': {
                schema: {
                    type: 'object',
                    properties: {
                        token: {
                            type: 'string',
                        },
                    },
                },
            },
        },
    })
    async login(
        @requestBody(CredentialsRequestBody) credentials: Credentials, //Create a credentials object out of the request body
    ): Promise<{token: string}> {
        // Check if it is a user from the app
        const user = await this.userService.verifyCredentials(credentials);
        const userProfile = this.userService.convertToUserProfile(user);
        // create a JWT based on the user profile
        const token = await this.jwtService.generateToken(userProfile);
        return {token};
    }

    // Endpoint to retrieve the logged in user details (no need to send user id)
    @authenticate('jwt')
    @get('/users/whoami')
    @response(200, {
        description: 'Return current user',
        content: {
            'application/json': {
                schema: {
                    type: 'string',
                },
            },
        },
    })
    async whoAmI(
        @inject(SecurityBindings.USER) currentUserProfile: UserProfile, //Recover id from logged in user
    ): Promise<AppUser> {
        const userId = currentUserProfile[securityId];
        const user = await this.appUserRepository.findById(parseInt(userId));
        const profilePic = await this.mediaRepository.findOne({where: {name: `${user.username}_avatar`}});
        return Object.assign({info: user, avatar: profilePic});
    }

    // Endpoint to add a new user to the app
    @post('/users')
    @response(200, {
        description: 'AppUser model instance!',
        content: {
            'application/json': {
                schema: getModelSchemaRef(AppUser),
            },
        },
    })
    @intercept(ValidateUserInterceptor.BINDING_KEY) //Validate the data given
    async create(
        @requestBody({
            content: {
                'application/json': {
                    schema: getModelSchemaRef(AppUser, {
                        title: 'NewAppUser',
                        exclude: ['id'],
                        includeRelations: true, //Allow users containing categories and media
                    }),
                },
            },
        })
            appUser: Omit<AppUser, 'id'>,
    ): Promise<AppUser> {
        const salt = await genSalt(12);

        appUser.passwordHash = await hash(appUser.passwordHash, salt); //Hash password (bcrypt 12 rounds)
        //Create user without navigational properties
        const newUser = Object.assign({
            firstName: appUser.firstName,
            lastName: appUser.lastName,
            email: appUser.email,
            birthDate: appUser.birthDate,
            address: appUser.address,
            passwordHash: appUser.passwordHash,
            username: appUser.username,
        });

        // Add new user to db
        const user = await this.appUserRepository.create(newUser);

        //User not created, throw error
        if (!user) {
            throw new CustomResponse('User couldn\'t been stored', 404);
        }

        //User created, create media and relate it to the user
        const newMedia = Object.assign({
            name: appUser.profilePicture.name,
            data: appUser.profilePicture.data,
            dataType: appUser.profilePicture.dataType,
            appUserId: user.getId(),
        });

        //Add given profile picture to db
        const media = await this.mediaRepository.create(newMedia);

        //User not created, throw error
        if (!media) {
            throw new CustomResponse('Media couldn\'t been stored', 404);
        }

        const linkedCategories = await this.linkExpertCategories(user.getId(), appUser.expertCategories);
        return Object.assign({info: user, avatar: newMedia, expertCategories: linkedCategories});
    }


    private async linkExpertCategories(userId: number, categories: ExpertCategory[]) {
        if (categories.length === 0) {
            return;
        }

        const supportedCategories = await this.expertCategoryRepository.find(undefined);
        const converted = AppUserController.convertCategoriesToDictionary(supportedCategories);
        const linkedCategories = [];

        // Link the expert categories.
        for (const expertCategory of categories) {
            const name = expertCategory.categoryName;
            if (!(name in converted)) {
                continue;
            }

            await this.appUserRepository.expertCategories(userId).link(converted[name]);
            linkedCategories.push(expertCategory);
        }

        return linkedCategories;
    }

    private static convertCategoriesToDictionary(categories: ExpertCategory[]) {
        // eslint-disable-next-line @typescript-eslint/ban-ts-comment
        // @ts-ignore
        return Object.assign({}, ...categories.map((x) => ({[x.categoryName]: x.id})));
    }

    // Endpoint to retrieve all the users matching the filter
    @authenticate('jwt')
    @get('/users')
    @response(200, {
        description: 'Array of AppUser model instances',
        content: {
            'application/json': {
                schema: {
                    type: 'array',
                    items: getModelSchemaRef(AppUser, {includeRelations: true}),
                },
            },
        },
    })
    async find(
        @param.filter(AppUser) filter?: Filter<AppUser>,
    ): Promise<AppUser[]> {
        return this.appUserRepository.find(filter);
    }

    // Endpoint to retrieve details from given user
    @authenticate('jwt')
    @get('/users/{id}')
    @response(200, {
        description: 'AppUser model instance',
        content: {
            'application/json': {
                schema: getModelSchemaRef(AppUser, {includeRelations: true}), //Return user together with profile picture
            },
        },
    })
    async findById(
        @param.path.number('id') id: number, //Retrieve user id from the user
        @param.filter(AppUser, {exclude: 'where'}) filter?: FilterExcludingWhere<AppUser>,
    ): Promise<AppUser> {
        return this.appUserRepository.findById(id, filter);
    }

    // Endpoint to update the data from a certain user
    @authenticate('jwt')
    @patch('/users/{id}')
    @response(204, {
        description: 'AppUser PATCH success',
    })
    async updateById(
        @param.path.number('id') id: number, //Retrieve user id from url
        @requestBody({
            content: {
                'application/json': {
                    schema: getModelSchemaRef(AppUser, {partial: true}), //Allow some data missing (only fields to update)
                },
            },
        })
            appUser: AppUser,
    ): Promise<void> {
        await this.appUserRepository.updateById(id, appUser);
    }


    // Endpoint to delete a user from db
    @authenticate('jwt')
    @del('/users/{id}')
    @response(204, {
        description: 'AppUser DELETE success',
    })
    async deleteById(@param.path.number('id') id: number): Promise<void> {
        await this.appUserRepository.deleteById(id);
    }

    // Endpoint to update data from multiple users 
    @authenticate('jwt')
    @patch('/users')
    @response(200, {
        description: 'AppUser PATCH success count',
        content: {'application/json': {schema: CountSchema}},
    })
    async updateAll(
        @requestBody({
            content: {
                'application/json': {
                    schema: getModelSchemaRef(AppUser, {partial: true}), //Allow some data missing (only fields to update)
                },
            },
        })
            appUser: AppUser, //Create an user object with the data attached in the request body
        @param.where(AppUser) where?: Where<AppUser>,
    ): Promise<Count> {
        //Try to update all the users matching a certain condition
        return this.appUserRepository.updateAll(appUser, where);
    }

    // Endpoint to retrieve amount of user in the system matching the filter
    @authenticate('jwt')
    @get('/users/count')
    @response(200, {
        description: 'AppUser model count',
        content: {'application/json': {schema: CountSchema}},
    })
    async count(
        @param.where(AppUser) where?: Where<AppUser>,
    ): Promise<Count> {
        return this.appUserRepository.count(where);
    }

    // Endpoint to replace a user by another one reusing the id
    @authenticate('jwt')
    @put('/users/{id}')
    @response(204, {
        description: 'AppUser PUT success',
    })
    async replaceById(
        @param.path.number('id') id: number, //Retrieve user id from url
        @requestBody() appUser: AppUser, //Create user object out of the request body
    ): Promise<void> {
        await this.appUserRepository.replaceById(id, appUser);
    }
}
