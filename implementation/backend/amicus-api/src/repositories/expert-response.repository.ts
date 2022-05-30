import {inject} from '@loopback/core';
import {DefaultCrudRepository} from '@loopback/repository';
import {AmicusDatabaseDataSource} from '../datasources';
import {ExpertResponse, ExpertResponseRelations} from '../models';

export class ExpertResponseRepository extends DefaultCrudRepository<
  ExpertResponse,
  typeof ExpertResponse.prototype.id,
  ExpertResponseRelations
> {
  constructor(
    @inject('datasources.AmicusDatabase') dataSource: AmicusDatabaseDataSource,
  ) {
    super(ExpertResponse, dataSource);
  }
}
