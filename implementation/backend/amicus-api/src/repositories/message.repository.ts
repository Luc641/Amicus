import {inject} from '@loopback/core';
import {BelongsToAccessor, DefaultCrudRepository} from '@loopback/repository';
import {AmicusDatabaseDataSource} from '../datasources';
import {Message, MessageRelations, Request} from '../models';

export class MessageRepository extends DefaultCrudRepository<
  Message,
  typeof Message.prototype.id,
  MessageRelations
> {

  public readonly request: BelongsToAccessor<Request, typeof Message.prototype.id>;

  constructor(
    @inject('datasources.AmicusDatabase') dataSource: AmicusDatabaseDataSource,) {
    super(Message, dataSource);
  }
}
