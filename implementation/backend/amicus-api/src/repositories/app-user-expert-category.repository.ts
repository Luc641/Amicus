import {inject} from '@loopback/core';
import {DefaultCrudRepository} from '@loopback/repository';
import {AmicusDatabaseDataSource} from '../datasources';
import {AppUserExpertCategory, AppUserExpertCategoryRelations} from '../models';

export class AppUserExpertCategoryRepository extends DefaultCrudRepository<
  AppUserExpertCategory,
  typeof AppUserExpertCategory.prototype.id,
  AppUserExpertCategoryRelations
> {
  constructor(
    @inject('datasources.AmicusDatabase') dataSource: AmicusDatabaseDataSource,
  ) {
    super(AppUserExpertCategory, dataSource);
  }
}
