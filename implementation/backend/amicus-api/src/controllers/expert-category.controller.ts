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

export class ExpertCategoryController {
  constructor(
    @repository(ExpertCategoryRepository)
    public expertCategoryRepository : ExpertCategoryRepository,
  ) {}

  @post('/expert-categories')
  @response(200, {
    description: 'ExpertCategory model instance',
    content: {'application/json': {schema: getModelSchemaRef(ExpertCategory)}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(ExpertCategory, {
            title: 'NewExpertCategory',
            exclude: ['id'],
          }),
        },
      },
    })
    expertCategory: Omit<ExpertCategory, 'id'>,
  ): Promise<ExpertCategory> {
    return this.expertCategoryRepository.create(expertCategory);
  }

  @get('/expert-categories/count')
  @response(200, {
    description: 'ExpertCategory model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(ExpertCategory) where?: Where<ExpertCategory>,
  ): Promise<Count> {
    return this.expertCategoryRepository.count(where);
  }

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

  @patch('/expert-categories')
  @response(200, {
    description: 'ExpertCategory PATCH success count',
    content: {'application/json': {schema: CountSchema}},
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(ExpertCategory, {partial: true}),
        },
      },
    })
    expertCategory: ExpertCategory,
    @param.where(ExpertCategory) where?: Where<ExpertCategory>,
  ): Promise<Count> {
    return this.expertCategoryRepository.updateAll(expertCategory, where);
  }

  @get('/expert-categories/{id}')
  @response(200, {
    description: 'ExpertCategory model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(ExpertCategory, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.number('id') id: number,
    @param.filter(ExpertCategory, {exclude: 'where'}) filter?: FilterExcludingWhere<ExpertCategory>
  ): Promise<ExpertCategory> {
    return this.expertCategoryRepository.findById(id, filter);
  }

  @patch('/expert-categories/{id}')
  @response(204, {
    description: 'ExpertCategory PATCH success',
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(ExpertCategory, {partial: true}),
        },
      },
    })
    expertCategory: ExpertCategory,
  ): Promise<void> {
    await this.expertCategoryRepository.updateById(id, expertCategory);
  }

  @put('/expert-categories/{id}')
  @response(204, {
    description: 'ExpertCategory PUT success',
  })
  async replaceById(
    @param.path.number('id') id: number,
    @requestBody() expertCategory: ExpertCategory,
  ): Promise<void> {
    await this.expertCategoryRepository.replaceById(id, expertCategory);
  }

  @del('/expert-categories/{id}')
  @response(204, {
    description: 'ExpertCategory DELETE success',
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.expertCategoryRepository.deleteById(id);
  }
}
