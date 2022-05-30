import {inject, Getter} from '@loopback/core';
import {
    DefaultCrudRepository,
    repository, BelongsToAccessor, HasOneRepositoryFactory,
} from '@loopback/repository';
import {AmicusDatabaseDataSource} from '../datasources';
import {Request, RequestRelations, ExpertCategory, ExpertResponse, Media} from '../models';
import {ExpertCategoryRepository} from './expert-category.repository';
import {ExpertResponseRepository} from './expert-response.repository';
import {MediaRepository} from './media.repository';

export class RequestRepository extends DefaultCrudRepository<Request,
    typeof Request.prototype.id,
    RequestRelations> {

    public readonly expertCategory: BelongsToAccessor<ExpertCategory, typeof Request.prototype.id>;

    public readonly expertResponse: HasOneRepositoryFactory<ExpertResponse, typeof Request.prototype.id>;

    public readonly media: BelongsToAccessor<Media, typeof Request.prototype.id>;

    constructor(
        @inject('datasources.AmicusDatabase') dataSource: AmicusDatabaseDataSource, @repository.getter('ExpertCategoryRepository') protected expertCategoryRepositoryGetter: Getter<ExpertCategoryRepository>, @repository.getter('ExpertResponseRepository') protected expertResponseRepositoryGetter: Getter<ExpertResponseRepository>, @repository.getter('MediaRepository') protected mediaRepositoryGetter: Getter<MediaRepository>,
    ) {
        super(Request, dataSource);
        this.media = this.createBelongsToAccessorFor('media', mediaRepositoryGetter);
        this.registerInclusionResolver('media', this.media.inclusionResolver);
        this.expertResponse = this.createHasOneRepositoryFactoryFor('expertResponse', expertResponseRepositoryGetter);
        this.expertCategory = this.createBelongsToAccessorFor('expertCategory', expertCategoryRepositoryGetter);
        this.registerInclusionResolver('expertCategory', this.expertCategory.inclusionResolver)
    }
}
