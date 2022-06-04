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
  Request,
} from '../models';
import {AppUserRepository} from '../repositories';

export class AppUserRequestController {
  constructor(
    @repository(AppUserRepository) protected appUserRepository: AppUserRepository,
  ) { }

  // @get('/app-users/{id}/requests', {
  //   responses: {
  //     '200': {
  //       description: 'Array of AppUser has many Request',
  //       content: {
  //         'application/json': {
  //           schema: {type: 'array', items: getModelSchemaRef(Request)},
  //         },
  //       },
  //     },
  //   },
  // })
  // async find(
  //   @param.path.number('id') id: number,
  //   @param.query.object('filter') filter?: Filter<Request>,
  // ): Promise<Request[]> {
  //   return this.appUserRepository.expertRequests(id).find(filter);
  // }

  // @post('/app-users/{id}/requests', {
  //   responses: {
  //     '200': {
  //       description: 'AppUser model instance',
  //       content: {'application/json': {schema: getModelSchemaRef(Request)}},
  //     },
  //   },
  // })
  // async create(
  //   @param.path.number('id') id: typeof AppUser.prototype.id,
  //   @requestBody({
  //     content: {
  //       'application/json': {
  //         schema: getModelSchemaRef(Request, {
  //           title: 'NewRequestInAppUser',
  //           exclude: ['id'],
  //           optional: ['expertId']
  //         }),
  //       },
  //     },
  //   }) request: Omit<Request, 'id'>,
  // ): Promise<Request> {
  //   return this.appUserRepository.expertRequests(id).create(request);
  // }

  // @patch('/app-users/{id}/requests', {
  //   responses: {
  //     '200': {
  //       description: 'AppUser.Request PATCH success count',
  //       content: {'application/json': {schema: CountSchema}},
  //     },
  //   },
  // })
  // async patch(
  //   @param.path.number('id') id: number,
  //   @requestBody({
  //     content: {
  //       'application/json': {
  //         schema: getModelSchemaRef(Request, {partial: true}),
  //       },
  //     },
  //   })
  //   request: Partial<Request>,
  //   @param.query.object('where', getWhereSchemaFor(Request)) where?: Where<Request>,
  // ): Promise<Count> {
  //   return this.appUserRepository.expertRequests(id).patch(request, where);
  // }

  // @del('/app-users/{id}/requests', {
  //   responses: {
  //     '200': {
  //       description: 'AppUser.Request DELETE success count',
  //       content: {'application/json': {schema: CountSchema}},
  //     },
  //   },
  // })
  // async delete(
  //   @param.path.number('id') id: number,
  //   @param.query.object('where', getWhereSchemaFor(Request)) where?: Where<Request>,
  // ): Promise<Count> {
  //   return this.appUserRepository.expertRequests(id).delete(where);
  // }
}
