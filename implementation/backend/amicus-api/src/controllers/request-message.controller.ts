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
  param, post,
  requestBody
} from '@loopback/rest';
import {Message, Request} from '../models';
import {RequestRepository} from '../repositories';

export class RequestMessageController {
  constructor(
    @repository(RequestRepository) protected requestRepository: RequestRepository,
  ) { }

  @get('/requests/{id}/message', {
    responses: {
      '200': {
        description: 'Array of Request has many Message',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(Message)},
          },
        },
      },
    },
  })
  async find(
    @param.path.number('id') id: number,
    @param.query.object('filter') filter?: Filter<Message>,
  ): Promise<Message[]> {
    return this.requestRepository.message(id).find(filter);
  }

  @post('/requests/{id}/message', {
    responses: {
      '200': {
        description: 'Request model instance',
        content: {'application/json': {schema: getModelSchemaRef(Message)}},
      },
    },
  })
  async create(
    @param.path.number('id') id: typeof Request.prototype.id,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Message, {
            title: 'NewMessageInRequest',
            exclude: ['id']
          }),
        },
      },
    }) message: Omit<Message, 'id'>,
  ): Promise<Message> {
    return this.requestRepository.message(id).create(message);
  }

  @del('/requests/{id}/message', {
    responses: {
      '200': {
        description: 'Request.MESSAGE DELETE success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async delete(
    @param.path.number('id') id: number,
    @param.query.object('where', getWhereSchemaFor(Message)) where?: Where<Message>,
  ): Promise<Count> {
    return this.requestRepository.message(id).delete(where);
  }
}
