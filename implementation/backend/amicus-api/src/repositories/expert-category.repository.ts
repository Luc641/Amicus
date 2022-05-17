import {inject} from '@loopback/core';
import {DefaultCrudRepository} from '@loopback/repository';
import {AmicusDatabaseDataSource} from '../datasources';
import {ExpertCategory, ExpertCategoryRelations} from '../models';

export class ExpertCategoryRepository extends DefaultCrudRepository<
  ExpertCategory,
  typeof ExpertCategory.prototype.id,
  ExpertCategoryRelations
> {
  constructor(
    @inject('datasources.AmicusDatabase') dataSource: AmicusDatabaseDataSource,
  ) {
    super(ExpertCategory, dataSource);
  }
}
