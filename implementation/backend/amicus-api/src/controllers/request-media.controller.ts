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
  Media, Request
} from '../models';
import {RequestRepository} from '../repositories';

export class RequestMediaController {
  constructor(
    @repository(RequestRepository) protected requestRepository: RequestRepository,
  ) { }

  @get('/requests/{id}/media', {
    responses: {
      '200': {
        description: 'Array of Request has many Media',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(Media)},
          },
        },
      },
    },
  })
  async find(
    @param.path.number('id') id: number,
    @param.query.object('filter') filter?: Filter<Media>,
  ): Promise<Media[]> {
    return this.requestRepository.media(id).find(filter);
  }

  @post('/requests/{id}/media', {
    responses: {
      '200': {
        description: 'Request model instance',
        content: {'application/json': {schema: getModelSchemaRef(Media)}},
      },
    },
  })
  async create(
    @param.path.number('id') id: typeof Request.prototype.id,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Media, {
            title: 'NewMediaInRequest',
            exclude: ['id']
          }),
        },
      },
    }) media: Omit<Media, 'id'>,
  ): Promise<Media> {
    return this.requestRepository.media(id).create(media);
  }

  @patch('/requests/{id}/media', {
    responses: {
      '200': {
        description: 'Request.Media PATCH success count',
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
    return this.requestRepository.media(id).patch(media, where);
  }

  @del('/requests/{id}/media', {
    responses: {
      '200': {
        description: 'Request.Media DELETE success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async delete(
    @param.path.number('id') id: number,
    @param.query.object('where', getWhereSchemaFor(Media)) where?: Where<Media>,
  ): Promise<Count> {
    return this.requestRepository.media(id).delete(where);
  }
}
