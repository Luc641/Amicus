import {
  repository,
} from '@loopback/repository';
import {
  param,
  get,
  getModelSchemaRef,
} from '@loopback/rest';
import {
  Request,
  Media,
} from '../models';
import {RequestRepository} from '../repositories';

export class RequestMediaController {
  constructor(
    @repository(RequestRepository)
    public requestRepository: RequestRepository,
  ) { }

  // @get('/requests/{id}/media', {
  //   responses: {
  //     '200': {
  //       description: 'Media belonging to Request',
  //       content: {
  //         'application/json': {
  //           schema: {type: 'array', items: getModelSchemaRef(Media)},
  //         },
  //       },
  //     },
  //   },
  // })
  // async getMedia(
  //   @param.path.number('id') id: typeof Request.prototype.id,
  // ): Promise<Media> {
  //   return this.requestRepository.media(id);
  // }
}
