// https://loopback.io/doc/en/lb4/HasManyThrough-relation.html

import {
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
import {
    AppUser,
    ExpertCategory,
} from '../models';
import {AppUserRepository, AppUserExpertCategoryRepository, ExpertCategoryRepository} from '../repositories';
import {CustomResponse} from '../responses/custom-response';
import {authenticate} from '@loopback/authentication';

export class AppUserExpertCategoryController {
    constructor(
        @repository(AppUserRepository) protected appUserRepository: AppUserRepository,
        @repository(ExpertCategoryRepository) protected expertCategoryRepository: ExpertCategoryRepository,
        @repository(AppUserExpertCategoryRepository) protected appUserExpertCategoryRepository: AppUserExpertCategoryRepository,
    ) {
    }

    // Endpoint to retrieve expert categories from a user
    @authenticate('jwt')
    @get('/app-users/{id}/expert-categories', {
        responses: {
            '200': {
                description: 'Expert categories belonging to the given user',
                content: {
                    'application/json': {
                        schema: {type: 'array', items: getModelSchemaRef(ExpertCategory)},
                    },
                },
            },
        },
    })
    async find(
        @param.path.number('id') id: number, //Get user id parameter from url
        @param.query.object('filter') filter?: Filter<ExpertCategory>,
    ): Promise<ExpertCategory[]> {
        return this.appUserRepository.expertCategories(id).find(filter);
    }

    // // Endpoint to add expert categories for a given user
    // @authenticate('jwt')
    // @post('/app-users/{id}/expert-categories', {
    //     responses: {
    //         '200': {
    //             description: 'Expert category added to given user',
    //             content: {
    //                 'application/json': {schema: getModelSchemaRef(ExpertCategory)},
    //             },
    //         },
    //     },
    // })
    // async create(
    //     @param.path.number('id') userId: typeof AppUser.prototype.id, //Retrive user id from url
    //     @requestBody({
    //         content: {
    //             'application/json': {
    //                 schema: getModelSchemaRef(ExpertCategory, { //Use request body to create a expert category object
    //                     title: 'NewExpertCategoryInAppUser',
    //                     exclude: ['id'],
    //                 }),
    //             },
    //         },
    //     }) categoryData: Omit<ExpertCategory, 'id'>,
    // ): Promise<ExpertCategory> {

    //     // Check if expert category already exists
    //     const expertCategory = await this.expertCategoryRepository.findOne({
    //         where: {categoryName: categoryData.categoryName},
    //     });

    //     //If exists, try to find if given user already has this expert category
    //     if (expertCategory) {
    //         const categoryMatch = await this.appUserExpertCategoryRepository.findOne({
    //             where: {appUserId: userId, expertCategoryId: expertCategory.getId()},
    //         });

    //         // No expert category found for given user - Add it to him/her
    //         if (!categoryMatch) {
    //             await this.appUserRepository.expertCategories(userId).link(expertCategory.getId());
    //             return expertCategory;
    //         } else {
    //             throw new CustomResponse('Expert category already assigned to the given user', 406);
    //         }

    //     } else {
    //         throw new CustomResponse('No expert category matching the one given', 404);
    //     }
    // }

    // // Endpoint used to remove expert category from the given user
    // @authenticate('jwt')
    // @del('/app-users/{id}/expert-categories', {
    //     responses: {
    //         '200': {
    //             description: 'Expert Category successfully removed from user',
    //             content: {
    //                 'application/json': {schema: getModelSchemaRef(ExpertCategory)},
    //             },
    //         },
    //     },
    // })
    // async delete(
    //     @param.path.number('id') userId: number, //Retrive user id from url
    //     @requestBody({
    //         content: {
    //             'application/json': {
    //                 schema: getModelSchemaRef(ExpertCategory, { //Use request body to create a expert category object
    //                     title: 'DelExpertCategoryInAppUser',
    //                     exclude: ['id'],
    //                 }),
    //             },
    //         },
    //     }) categoryData: Omit<ExpertCategory, 'id'>,
    // ): Promise<ExpertCategory> {

    //     // Check if expert category already exists
    //     const expertCategory = await this.expertCategoryRepository.findOne({
    //         where: {categoryName: categoryData.categoryName},
    //     });

    //     //If exists, try to find if given user has the given expert category
    //     if (expertCategory) {
    //         const categoryMatch = await this.appUserExpertCategoryRepository.findOne({
    //             where: {appUserId: userId, expertCategoryId: expertCategory.getId()},
    //         });

    //         //If the user has it, remove the relation
    //         if (categoryMatch) {
    //             await this.appUserRepository.expertCategories(userId).unlink(expertCategory.getId());
    //             return expertCategory;
    //         } else {
    //             throw new CustomResponse('Expert category not assigned to the given user', 406);
    //         }

    //     } else {
    //         throw new CustomResponse('No expert category matching the one given', 404);
    //     }
    // }
}
