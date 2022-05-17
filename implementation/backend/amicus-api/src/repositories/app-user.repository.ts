import {inject, Getter} from '@loopback/core';
import {DefaultCrudRepository, repository, HasManyThroughRepositoryFactory} from '@loopback/repository';
import {AmicusDatabaseDataSource} from '../datasources';
import {AppUser, AppUserRelations, ExpertCategory, AppUserExpertCategory} from '../models';
import {Credentials} from "../services/app-user.service";
import {AppUserExpertCategoryRepository} from './app-user-expert-category.repository';
import {ExpertCategoryRepository} from './expert-category.repository';

export class AppUserRepository extends DefaultCrudRepository<AppUser,
    typeof AppUser.prototype.id,
    AppUserRelations> {

  public readonly expertCategories: HasManyThroughRepositoryFactory<ExpertCategory, typeof ExpertCategory.prototype.id,
          AppUserExpertCategory,
          typeof AppUser.prototype.id
        >;

    constructor(
        @inject('datasources.AmicusDatabase') dataSource: AmicusDatabaseDataSource, @repository.getter('AppUserExpertCategoryRepository') protected appUserExpertCategoryRepositoryGetter: Getter<AppUserExpertCategoryRepository>, @repository.getter('ExpertCategoryRepository') protected expertCategoryRepositoryGetter: Getter<ExpertCategoryRepository>,
    ) {
        super(AppUser, dataSource);
      this.expertCategories = this.createHasManyThroughRepositoryFactoryFor('expertCategories', expertCategoryRepositoryGetter, appUserExpertCategoryRepositoryGetter,);
      this.registerInclusionResolver('expertCategories', this.expertCategories.inclusionResolver);
    }


    async findCredentials(
        userId: typeof AppUser.prototype.id,
    ): Promise<Credentials | undefined> {
        try {
            const user = await this.findById(userId);
            return {email: user.email, password: user.passwordHash}
        } catch (err) {
            if (err.code === 'ENTITY_NOT_FOUND') {
                return undefined;
            }
            throw err;
        }
    }
}
