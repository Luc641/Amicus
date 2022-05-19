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
  Media,
} from '../models';
import {AppUserRepository} from '../repositories';

export class AppUserMediaController {
  constructor(
    @repository(AppUserRepository) protected appUserRepository: AppUserRepository,
  ) { }

  @get('/app-users/{id}/media', {
    responses: {
      '200': {
        description: 'AppUser has one Media',
        content: {
          'application/json': {
            schema: getModelSchemaRef(Media),
          },
        },
      },
    },
  })
  async get(
    @param.path.number('id') id: number,
    @param.query.object('filter') filter?: Filter<Media>,
  ): Promise<Media> {
    return this.appUserRepository.profilePicture(id).get(filter);
  }

  @post('/app-users/{id}/media', {
    responses: {
      '200': {
        description: 'AppUser model instance',
        content: {'application/json': {schema: getModelSchemaRef(Media)}},
      },
    },
  })
  async create(
    @param.path.number('id') id: typeof AppUser.prototype.id,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Media, {
            title: 'NewMediaInAppUser',
            exclude: ['id'],
            optional: ['appUserId']
          }),
        },
      },
    }) media: Omit<Media, 'id'>,
  ): Promise<Media> {
    return this.appUserRepository.profilePicture(id).create(media);
  }

  @patch('/app-users/{id}/media', {
    responses: {
      '200': {
        description: 'AppUser.Media PATCH success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async patch(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Media, {partial: true}),
        },
      },
    })
    media: Partial<Media>,
    @param.query.object('where', getWhereSchemaFor(Media)) where?: Where<Media>,
  ): Promise<Count> {
    return this.appUserRepository.profilePicture(id).patch(media, where);
  }

  @del('/app-users/{id}/media', {
    responses: {
      '200': {
        description: 'AppUser.Media DELETE success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async delete(
    @param.path.number('id') id: number,
    @param.query.object('where', getWhereSchemaFor(Media)) where?: Where<Media>,
  ): Promise<Count> {
    return this.appUserRepository.profilePicture(id).delete(where);
  }
}
