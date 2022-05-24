import {Getter, inject} from '@loopback/core';
import {DefaultCrudRepository, HasManyRepositoryFactory, repository} from '@loopback/repository';
import {AmicusDatabaseDataSource} from '../datasources';
import {Media, Message, Request, RequestRelations} from '../models';
import {MediaRepository} from './media.repository';
import {MessageRepository} from './message.repository';

export class RequestRepository extends DefaultCrudRepository<
  Request,
  typeof Request.prototype.id,
  RequestRelations
> {

  public readonly media: HasManyRepositoryFactory<Media, typeof Request.prototype.id>;

  public readonly message: HasManyRepositoryFactory<Message, typeof Request.prototype.id>;

  constructor(
    @inject('datasources.AmicusDatabase') dataSource: AmicusDatabaseDataSource, @repository.getter('MediaRepository') protected mediaRepositoryGetter: Getter<MediaRepository>, @repository.getter('MessageRepository') protected messageRepositoryGetter: Getter<MessageRepository>,
  ) {
    super(Request, dataSource);
    this.message = this.createHasManyRepositoryFactoryFor('message', messageRepositoryGetter,);
    this.media = this.createHasManyRepositoryFactoryFor('media', mediaRepositoryGetter,);
    this.registerInclusionResolver('media', this.media.inclusionResolver);
    this.registerInclusionResolver('message', this.message.inclusionResolver);
  }
}
