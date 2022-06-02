import {Getter, inject} from '@loopback/core';
import {
    DefaultCrudRepository,
    HasManyRepositoryFactory,
    HasManyThroughRepositoryFactory,
    HasOneRepositoryFactory,
    repository,
} from '@loopback/repository';
import {AmicusDatabaseDataSource} from '../datasources';
import {AppUser, AppUserExpertCategory, AppUserRelations, ExpertCategory, Media, Request, DeviceToken} from '../models';
import {Credentials} from '../services/app-user.service';
import {AppUserExpertCategoryRepository} from './app-user-expert-category.repository';
import {ExpertCategoryRepository} from './expert-category.repository';
import {MediaRepository} from './media.repository';
import {RequestRepository} from './request.repository';
import {DeviceTokenRepository} from './device-token.repository';

export class AppUserRepository extends DefaultCrudRepository<AppUser,
    typeof AppUser.prototype.id,
    AppUserRelations> {

    public readonly expertCategories: HasManyThroughRepositoryFactory<ExpertCategory, typeof ExpertCategory.prototype.id,
        AppUserExpertCategory,
        typeof AppUser.prototype.id>;

    public readonly profilePicture: HasOneRepositoryFactory<Media, typeof AppUser.prototype.id>;

    public readonly ownRequests: HasManyRepositoryFactory<Request, typeof AppUser.prototype.id>;

    public readonly expertRequests: HasManyRepositoryFactory<Request, typeof AppUser.prototype.id>;

  public readonly deviceToken: HasOneRepositoryFactory<DeviceToken, typeof AppUser.prototype.id>;

    constructor(
        @inject('datasources.AmicusDatabase') dataSource: AmicusDatabaseDataSource,
        @repository.getter('AppUserExpertCategoryRepository')
        protected appUserExpertCategoryRepositoryGetter: Getter<AppUserExpertCategoryRepository>,
        @repository.getter('ExpertCategoryRepository')
        protected expertCategoryRepositoryGetter: Getter<ExpertCategoryRepository>,
        @repository.getter('MediaRepository')
        protected mediaRepositoryGetter: Getter<MediaRepository>,
        @repository.getter('RequestRepository')
        protected requestRepositoryGetter: Getter<RequestRepository>, @repository.getter('DeviceTokenRepository') protected deviceTokenRepositoryGetter: Getter<DeviceTokenRepository>,
    ) {
        super(AppUser, dataSource);
      this.deviceToken = this.createHasOneRepositoryFactoryFor('deviceToken', deviceTokenRepositoryGetter);
      this.registerInclusionResolver('deviceToken', this.deviceToken.inclusionResolver);
        this.expertRequests = this.createHasManyRepositoryFactoryFor('expertRequests', requestRepositoryGetter);
        this.registerInclusionResolver('expertRequests', this.expertRequests.inclusionResolver);
        this.ownRequests = this.createHasManyRepositoryFactoryFor('ownRequests', requestRepositoryGetter);
        this.registerInclusionResolver('ownRequests', this.ownRequests.inclusionResolver);
        this.profilePicture = this.createHasOneRepositoryFactoryFor('profilePicture', mediaRepositoryGetter);
        this.expertCategories = this.createHasManyThroughRepositoryFactoryFor('expertCategories',
            expertCategoryRepositoryGetter, appUserExpertCategoryRepositoryGetter);
        this.registerInclusionResolver('expertCategories', this.expertCategories.inclusionResolver);
    }


    async findCredentials(
        userId: typeof AppUser.prototype.id,
    ): Promise<Credentials | undefined> {
        try {
            const user = await this.findById(userId);
            return {email: user.email, password: user.passwordHash};
        } catch (err) {
            if (err.code === 'ENTITY_NOT_FOUND') {
                return undefined;
            }
            throw err;
        }
    }
}
