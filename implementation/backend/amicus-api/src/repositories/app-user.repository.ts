import {inject} from '@loopback/core';
import {DefaultCrudRepository} from '@loopback/repository';
import {AmicusDatabaseDataSource} from '../datasources';
import {AppUser, AppUserRelations} from '../models';
import {Credentials} from "../services/app-user.service";

export class AppUserRepository extends DefaultCrudRepository<AppUser,
    typeof AppUser.prototype.id,
    AppUserRelations> {
    constructor(
        @inject('datasources.AmicusDatabase') dataSource: AmicusDatabaseDataSource,
    ) {
        super(AppUser, dataSource);
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
