import {AppUserRepository, MediaRepository} from '../../repositories';
import {testdb} from '../fixtures/datasources/testdb.datasource';
import {AppUser} from "../../models";

export async function givenEmptyDatabase() {
    const appUserRepository = new AppUserRepository(testdb);
    const mediaRepository = new MediaRepository(testdb);

    await appUserRepository.deleteAll();
    await mediaRepository.deleteAll();
}

export function givenAppUserData(data?: Partial<AppUser>) {
    return Object.assign(
        {
            firstName: 'Friendly',
            lastName: 'Person',
            email: "friendly@person.com",
            birthDate: new Date(628021800000),
            address: "Venlo",
            passwordHash: "supersecurepassword",
            username: "amicus_user"
        },
        data,
    );
}

export async function givenAppUser(data?: Partial<AppUser>) {
    return new AppUserRepository(testdb).create(givenAppUserData(data));
}