import {
  Count,
  CountSchema,
  Filter,
  repository,
  Where
} from '@loopback/repository';
import {
  del,
  get,
  getModelSchemaRef,
  getWhereSchemaFor,
  param,
  patch,
  post,
  requestBody
} from '@loopback/rest';
import {
  AppUser, Request
} from '../models';
import {AppUserRepository, MediaRepository} from '../repositories';

export class AppUserRequestController {
  constructor(
    @repository(AppUserRepository) protected appUserRepository: AppUserRepository,
    @repository(MediaRepository) protected mediaRepository: MediaRepository,
  ) { }

  @get('/app-users/{id}/requests', {
    responses: {
      '200': {
        description: 'Array of AppUser has many Request',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(Request)},
          },
        },
      },
    },
  })
  async find(
    @param.path.number('id') id: number,
    @param.query.object('filter') filter?: Filter<Request>,
  ): Promise<Request[]> {
    return this.appUserRepository.requests(id).find(filter);
  }

  @post('/app-users/{id}/requests', {
    responses: {
      '200': {
        description: 'AppUser model instance',
        content: {'application/json': {schema: getModelSchemaRef(Request)}},
      },
    },
  })
  async create(
    @param.path.number('id') id: typeof AppUser.prototype.id,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Request, {
            title: 'NewRequestInAppUser',
            exclude: ['id'],
            optional: ['appUserId'],
            includeRelations: true
          }),
        },
      },
    }) request: Omit<Request, 'id'>,
  ): Promise<Request> {
    const newRequest = Object.assign({
      title: request.title,
      content: request.content,
      date: request.date,
      location: request.location,
      isOpen: true
    })
    const requestReturn = this.appUserRepository.requests(id).create(newRequest);
    const requestId = (await requestReturn).getId();
    request.media?.forEach((value) => {
      const newMedia = Object.assign({
        name: value.name,
        data: value.data,
        dataType: value.dataType,
        requestId: requestId
      })
      this.mediaRepository.create(newMedia)
    }
    )
    return requestReturn;
  }

  @patch('/app-users/{id}/requests', {
    responses: {
      '200': {
        description: 'AppUser.Request PATCH success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async patch(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Request, {partial: true}),
        },
      },
    })
    request: Partial<Request>,
    @param.query.object('where', getWhereSchemaFor(Request)) where?: Where<Request>,
  ): Promise<Count> {
    return this.appUserRepository.requests(id).patch(request, where);
  }

  @del('/app-users/{id}/requests', {
    responses: {
      '200': {
        description: 'AppUser.Request DELETE success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async delete(
    @param.path.number('id') id: number,
    @param.query.object('where', getWhereSchemaFor(Request)) where?: Where<Request>,
  ): Promise<Count> {
    return this.appUserRepository.requests(id).delete(where);
  }
}
