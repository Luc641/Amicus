// https://loopback.io/doc/en/lb4/HasManyThrough-relation.html

import {
  Count,
  CountSchema,
  Filter,
  repository,
} from '@loopback/repository';
  import {
  del,
  get,
  getModelSchemaRef,
  param,
  post,
  requestBody,
} from '@loopback/rest';
import { ServerResponse } from 'http';
import {
AppUser,
ExpertCategory,
} from '../models';
import {AppUserRepository, AppUserExpertCategoryRepository, ExpertCategoryRepository} from '../repositories';
import { CustomResponse } from '../responses/custom-response';

export class AppUserExpertCategoryController {
  constructor(
    @repository(AppUserRepository) protected appUserRepository: AppUserRepository,
    @repository(ExpertCategoryRepository) protected expertCategoryRepository: ExpertCategoryRepository,
    @repository(AppUserExpertCategoryRepository) protected appUserExpertCategoryRepository: AppUserExpertCategoryRepository,
  ) { }

  @get('/app-users/{id}/expert-categories', {
    responses: {
      '200': {
        description: 'Array of AppUser has many ExpertCategory through AppUserExpertCategory',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(ExpertCategory)},
          },
        },
      },
    },
  })
  async find(
    @param.path.number('id') id: number,
    @param.query.object('filter') filter?: Filter<ExpertCategory>,
  ): Promise<ExpertCategory[]> {
    return this.appUserRepository.expertCategories(id).find(filter);
  }

  @post('/app-users/{id}/expert-categories', {
    responses: {
      '200': {
        description: 'Expert category added to given user',
      },
    },
  })
  async create(
    @param.path.number('id') userId: typeof AppUser.prototype.id,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(ExpertCategory, {
            title: 'NewExpertCategoryInAppUser',
            exclude: ['id'],
          }),
        },
      },
    }) categoryData: Omit<ExpertCategory, 'id'>,
  ): Promise<void> {
    // return this.appUserRepository.expertCategories(id).create(expertCategory);

    const expertCategory = await this.expertCategoryRepository.findOne({
      where: {categoryName: categoryData.categoryName}
    })

    if(expertCategory) {
       const categoryMatch = await this.appUserExpertCategoryRepository.findOne({
        where: {appUserId: userId, expertCategoryId: expertCategory.getId()}
      }); 

      if(!categoryMatch){
        return this.appUserRepository.expertCategories(userId).link(expertCategory.getId());
      } else {
        throw new CustomResponse ("Expert category already assigned to the given user", 406);
      }

    } else {
      throw new CustomResponse ("No expert category matching the one given", 404);
    }
  }  

  @del('/app-users/{id}/expert-categories', {
    responses: {
      '200': {
        description: 'Expert Category successfully removed from user',
      },
    },
  })
  async delete(
    @param.path.number('id') userId: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(ExpertCategory, {
            title: 'NewExpertCategoryInAppUser',
            exclude: ['id'],
          }),
        },
      },
    }) categoryData: Omit<ExpertCategory, 'id'>,
  ): Promise<void> {
    
    const expertCategory = await this.expertCategoryRepository.findOne({
      where: {categoryName: categoryData.categoryName}
    })

    if(expertCategory) {
        const categoryMatch = await this.appUserExpertCategoryRepository.findOne({
        where: {appUserId: userId, expertCategoryId: expertCategory.getId()}
      }); 

      if(categoryMatch){
        return this.appUserRepository.expertCategories(userId).unlink(expertCategory.getId());
      } else {
        throw new CustomResponse ("Expert category not assigned to the given user", 406);
      }

    } else {
      throw new CustomResponse ("No expert category matching the one given", 404);
    }

    
  }
}
