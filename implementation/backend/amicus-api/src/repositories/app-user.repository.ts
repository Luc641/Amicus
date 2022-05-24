import {inject, Getter} from '@loopback/core';
import {DefaultCrudRepository, repository, HasManyThroughRepositoryFactory, HasOneRepositoryFactory, HasManyRepositoryFactory} from '@loopback/repository';
import {AmicusDatabaseDataSource} from '../datasources';
import {AppUser, AppUserRelations, ExpertCategory, AppUserExpertCategory, Media, Request} from '../models';
import {Credentials} from "../services/app-user.service";
import {AppUserExpertCategoryRepository} from './app-user-expert-category.repository';
import {ExpertCategoryRepository} from './expert-category.repository';
import {MediaRepository} from './media.repository';
import {RequestRepository} from './request.repository';

export class AppUserRepository extends DefaultCrudRepository<AppUser,
    typeof AppUser.prototype.id,
    AppUserRelations> {

    public readonly requests: HasManyRepositoryFactory<Request, typeof AppUser.prototype.id>;

    public readonly expertCategories: HasManyThroughRepositoryFactory<ExpertCategory, typeof ExpertCategory.prototype.id,
          AppUserExpertCategory,
          typeof AppUser.prototype.id
        >;

  public readonly profilePicture: HasOneRepositoryFactory<Media, typeof AppUser.prototype.id>;


    constructor(
        @inject('datasources.AmicusDatabase') dataSource: AmicusDatabaseDataSource, @repository.getter('AppUserExpertCategoryRepository') protected appUserExpertCategoryRepositoryGetter: Getter<AppUserExpertCategoryRepository>, @repository.getter('ExpertCategoryRepository') protected expertCategoryRepositoryGetter: Getter<ExpertCategoryRepository>, @repository.getter('MediaRepository') protected mediaRepositoryGetter: Getter<MediaRepository>,
        @repository.getter('RequestRepository') protected requestRepositoryGetter: Getter<RequestRepository>,
    ) {
        super(AppUser, dataSource);
        this.profilePicture = this.createHasOneRepositoryFactoryFor('profilePicture', mediaRepositoryGetter);
        this.expertCategories = this.createHasManyThroughRepositoryFactoryFor('expertCategories', expertCategoryRepositoryGetter, appUserExpertCategoryRepositoryGetter,);
        this.registerInclusionResolver('expertCategories', this.expertCategories.inclusionResolver);
        this.registerInclusionResolver('requests', this.requests.inclusionResolver);
        this.requests = this.createHasManyRepositoryFactoryFor('requests', requestRepositoryGetter,);
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
