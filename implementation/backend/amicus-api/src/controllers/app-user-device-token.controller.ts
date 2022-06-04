import {
    Count,
    CountSchema,
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
    post,
    requestBody,
} from '@loopback/rest';
import {
    AppUser,
    DeviceToken,
} from '../models';
import {AppUserRepository, DeviceTokenRepository} from '../repositories';

export class AppUserDeviceTokenController {
    constructor(
        @repository(AppUserRepository) protected appUserRepository: AppUserRepository,
        @repository(DeviceTokenRepository) protected deviceTokenRepository: DeviceTokenRepository,
    ) {
    }

    @post('/app-users/{id}/device-token', {
        responses: {
            '200': {
                description: 'AppUser model instance',
                content: {'application/json': {schema: getModelSchemaRef(DeviceToken)}},
            },
        },
    })
    async upsert(
        @param.path.number('id') id: typeof AppUser.prototype.id,
        @requestBody({
            content: {
                'application/json': {
                    schema: getModelSchemaRef(DeviceToken, {
                        title: 'NewDeviceTokenInAppUser',
                        exclude: ['id'],
                        optional: ['appUserId'],
                    }),
                },
            },
        }) deviceToken: Omit<DeviceToken, 'id'>,
    ): Promise<DeviceToken> {

        const existing = await this.deviceTokenRepository
            .findOne({where: {appUserId: deviceToken.appUserId}});

        if (existing) {
            existing.data = deviceToken.data;
            await this.deviceTokenRepository.replaceById(existing.id, existing);
            return existing;
        }
        return this.appUserRepository.deviceToken(id).create(deviceToken);
    }

    // @get('/app-users/{id}/device-token', {
    //     responses: {
    //         '200': {
    //             description: 'AppUser has one DeviceToken',
    //             content: {
    //                 'application/json': {
    //                     schema: getModelSchemaRef(DeviceToken),
    //                 },
    //             },
    //         },
    //     },
    // })
    // async get(
    //     @param.path.number('id') id: number,
    //     @param.query.object('filter') filter?: Filter<DeviceToken>,
    // ): Promise<DeviceToken> {
    //     return this.appUserRepository.deviceToken(id).get(filter);
    // }

    // @patch('/app-users/{id}/device-token', {
    //     responses: {
    //         '200': {
    //             description: 'AppUser.DeviceToken PATCH success count',
    //             content: {'application/json': {schema: CountSchema}},
    //         },
    //     },
    // })
    // async patch(
    //     @param.path.number('id') id: number,
    //     @requestBody({
    //         content: {
    //             'application/json': {
    //                 schema: getModelSchemaRef(DeviceToken, {partial: true}),
    //             },
    //         },
    //     })
    //         deviceToken: Partial<DeviceToken>,
    //     @param.query.object('where', getWhereSchemaFor(DeviceToken)) where?: Where<DeviceToken>,
    // ): Promise<Count> {
    //     return this.appUserRepository.deviceToken(id).patch(deviceToken, where);
    // }

    // @del('/app-users/{id}/device-token', {
    //     responses: {
    //         '200': {
    //             description: 'AppUser.DeviceToken DELETE success count',
    //             content: {'application/json': {schema: CountSchema}},
    //         },
    //     },
    // })
    // async delete(
    //     @param.path.number('id') id: number,
    //     @param.query.object('where', getWhereSchemaFor(DeviceToken)) where?: Where<DeviceToken>,
    // ): Promise<Count> {
    //     return this.appUserRepository.deviceToken(id).delete(where);
    // }
}
