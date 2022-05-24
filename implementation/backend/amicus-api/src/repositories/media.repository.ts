import {inject} from '@loopback/core';
import {BelongsToAccessor, DefaultCrudRepository} from '@loopback/repository';
import {AmicusDatabaseDataSource} from '../datasources';
import {Media, MediaRelations, Message, Request} from '../models';

export class MediaRepository extends DefaultCrudRepository<
  Media,
  typeof Media.prototype.id,
  MediaRelations
> {

  public readonly request: BelongsToAccessor<Request, typeof Media.prototype.id>;
  public readonly message: BelongsToAccessor<Message, typeof Media.prototype.id>;

  constructor(
    @inject('datasources.AmicusDatabase') dataSource: AmicusDatabaseDataSource,) {
    super(Media, dataSource);
  }
}
