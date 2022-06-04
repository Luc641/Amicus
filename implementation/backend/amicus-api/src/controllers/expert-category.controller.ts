import {
  Count,
  CountSchema,
  Filter,
  FilterExcludingWhere,
  repository,
  Where,
} from '@loopback/repository';
import {
  post,
  param,
  get,
  getModelSchemaRef,
  patch,
  put,
  del,
  requestBody,
  response,
} from '@loopback/rest';
import {ExpertCategory} from '../models';
import {ExpertCategoryRepository} from '../repositories';
import {authenticate} from '@loopback/authentication';

export class ExpertCategoryController {
  constructor(
    @repository(ExpertCategoryRepository)
    public expertCategoryRepository : ExpertCategoryRepository,
  ) {}

  // Endpoint to get all the expert categories matching filter
  @get('/expert-categories')
  @response(200, {
    description: 'Array of ExpertCategory model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(ExpertCategory, {includeRelations: true}),
        },
      },
    },
  })
  async find(
    @param.filter(ExpertCategory) filter?: Filter<ExpertCategory>,
  ): Promise<ExpertCategory[]> {
    return this.expertCategoryRepository.find(filter);
  }

  // // Endpoint to add a new expert category
  // @authenticate('jwt')
  // @post('/expert-categories')
  // @response(200, {
  //   description: 'ExpertCategory model instance',
  //   content: {'application/json': {schema: getModelSchemaRef(ExpertCategory)}},
  // })
  // async create(
  //   @requestBody({
  //     content: {
  //       'application/json': {
  //         schema: getModelSchemaRef(ExpertCategory, { //Create expert category object out of request body
  //           title: 'NewExpertCategory',
  //           exclude: ['id'],
  //         }),
  //       },
  //     },
  //   })
  //   expertCategory: Omit<ExpertCategory, 'id'>,
  // ): Promise<ExpertCategory> {
  //   return this.expertCategoryRepository.create(expertCategory);
  // }

  // // Endpoint to retrieve a certain expert category
  // @authenticate('jwt')
  // @get('/expert-categories/{id}')
  // @response(200, {
  //   description: 'ExpertCategory model instance',
  //   content: {
  //     'application/json': {
  //       schema: getModelSchemaRef(ExpertCategory, {includeRelations: true}),
  //     },
  //   },
  // })
  // async findById(
  //   @param.path.number('id') id: number, //Retrieve expert category id from url
  //   @param.filter(ExpertCategory, {exclude: 'where'}) filter?: FilterExcludingWhere<ExpertCategory>
  // ): Promise<ExpertCategory> {
  //   return this.expertCategoryRepository.findById(id, filter);
  // }

  // // Endpoint to update a certain expert category
  // @authenticate('jwt')
  // @patch('/expert-categories/{id}')
  // @response(204, {
  //   description: 'ExpertCategory PATCH success',
  // })
  // async updateById(
  //   @param.path.number('id') id: number,
  //   @requestBody({
  //     content: {
  //       'application/json': {
  //         schema: getModelSchemaRef(ExpertCategory, {partial: true}), // Allow expert category with missing fields
  //       },
  //     },
  //   })
  //   expertCategory: ExpertCategory,
  // ): Promise<void> {
  //   await this.expertCategoryRepository.updateById(id, expertCategory);
  // }

  // // Endpoint to replace an expert category by another one
  // @authenticate('jwt')
  // @put('/expert-categories/{id}')
  // @response(204, {
  //   description: 'ExpertCategory PUT success',
  // })
  // async replaceById(
  //   @param.path.number('id') id: number, //Retrieve id from expert category to be replaced
  //   @requestBody() expertCategory: ExpertCategory, //Create new expert category out of the request body
  // ): Promise<void> {
  //   await this.expertCategoryRepository.replaceById(id, expertCategory);
  // }

  // // Endpoint to delete a certain expert category from the db
  // @authenticate('jwt')
  // @del('/expert-categories/{id}')
  // @response(204, {
  //   description: 'ExpertCategory DELETE success',
  // })
  // async deleteById(@param.path.number('id') id: number): Promise<void> { //Retrieve id from url
  //   await this.expertCategoryRepository.deleteById(id);
  // }

  // // Endpoint to get total number of expert categories in db
  // @authenticate('jwt')
  // @get('/expert-categories/count')
  // @response(200, {
  //   description: 'ExpertCategory model count',
  //   content: {'application/json': {schema: CountSchema}},
  // })
  // async count(
  //   @param.where(ExpertCategory) where?: Where<ExpertCategory>,
  // ): Promise<Count> {
  //   return this.expertCategoryRepository.count(where);
  // }

  // // Endpoint to update all the expert categories matching a condition
  // @authenticate('jwt')
  // @patch('/expert-categories')
  // @response(200, {
  //   description: 'ExpertCategory PATCH success count',
  //   content: {'application/json': {schema: CountSchema}},
  // })
  // async updateAll(
  //   @requestBody({
  //     content: {
  //       'application/json': {
  //         schema: getModelSchemaRef(ExpertCategory, {partial: true}), // Allow expert category with missing fields
  //       },
  //     },
  //   })
  //   expertCategory: ExpertCategory,
  //   @param.where(ExpertCategory) where?: Where<ExpertCategory>,
  // ): Promise<Count> {
  //   //Update all the expert categories matching the condition with the given fields
  //   return this.expertCategoryRepository.updateAll(expertCategory, where);
  // }
}
