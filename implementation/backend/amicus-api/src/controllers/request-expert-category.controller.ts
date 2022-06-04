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
  ExpertCategory,
} from '../models';
import {RequestRepository} from '../repositories';

export class RequestExpertCategoryController {
  constructor(
    @repository(RequestRepository)
    public requestRepository: RequestRepository,
  ) { }

  // @get('/requests/{id}/expert-category', {
  //   responses: {
  //     '200': {
  //       description: 'ExpertCategory belonging to Request',
  //       content: {
  //         'application/json': {
  //           schema: {type: 'array', items: getModelSchemaRef(ExpertCategory)},
  //         },
  //       },
  //     },
  //   },
  // })
  // async getExpertCategory(
  //   @param.path.number('id') id: typeof Request.prototype.id,
  // ): Promise<ExpertCategory> {
  //   return this.requestRepository.expertCategory(id);
  // }
}
