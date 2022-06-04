import {
    Filter,
    repository,
    Where,
} from '@loopback/repository';
import {
    del,
    get,
    getModelSchemaRef,
    getWhereSchemaFor,
    param,
    patch,
    requestBody,
} from '@loopback/rest';
import {
    Media,
} from '../models';
import {AppUserRepository} from '../repositories';
import {authenticate} from '@loopback/authentication';

export class AppUserMediaController {
    constructor(
        @repository(AppUserRepository) protected appUserRepository: AppUserRepository,
    ) {
    }

    // // Endpoint retrieve profile picture for the given user
    // @authenticate('jwt')
    // @get('/app-users/{id}/media', {
    //     responses: {
    //         '200': {
    //             description: 'AppUser profile picture',
    //             content: {
    //                 'application/json': {
    //                     schema: getModelSchemaRef(Media),
    //                 },
    //             },
    //         },
    //     },
    // })
    // async get(
    //     @param.path.number('id') id: number, //Retrieve user id from the url
    //     @param.query.object('filter') filter?: Filter<Media>,
    // ): Promise<Media> {
    //     return this.appUserRepository.profilePicture(id).get(filter);
    // }

    // // Endpoint to update users profile picture
    // @authenticate('jwt')
    // @patch('/app-users/{id}/media', {
    //     responses: {
    //         '200': {
    //             description: 'AppUser profile picture successfully updated',
    //         },
    //     },
    // })
    // async patch(
    //     @param.path.number('id') id: number, //Retrieve user id from the url
    //     @requestBody({
    //         content: {
    //             'application/json': {
    //                 schema: getModelSchemaRef(Media), //Use request body to create a media object
    //             },
    //         },
    //     })
    //         media: Partial<Media>,
    //     @param.query.object('where', getWhereSchemaFor(Media)) where?: Where<Media>,
    // ): Promise<Media> {
    //     await this.appUserRepository.profilePicture(id).patch(media, where); //Update the profile picture
    //     return new Promise<Media>(() => media); //Return new profile picture saved in db
    // }

    // // Endpoint to delete profile picture from given user
    // @authenticate('jwt')
    // @del('/app-users/{id}/media', {
    //     responses: {
    //         '200': {
    //             description: 'AppUser profile successfully picture deleted',
    //             content: {'application/json': {schema: Media}},
    //         },
    //     },
    // })
    // async delete(
    //     @param.path.number('id') id: number, //Retrieve user id from the url
    //     @param.query.object('where', getWhereSchemaFor(Media)) where?: Where<Media>,
    // ): Promise<Media> {
    //     await this.appUserRepository.profilePicture(id).delete(where); //Remove profile picture from given user
    //     return new Promise<Media>(() => where); //Return deleted profile picture
    // }
}
