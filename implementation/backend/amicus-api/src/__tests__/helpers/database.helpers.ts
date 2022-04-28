import {AppUserRepository, MediaRepository} from '../../repositories';
import {testdb} from '../fixtures/datasources/testdb.datasource';
import {AppUser} from "../../models";
import * as fs from "fs";

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

export function givenMediaData() {
    const file = fs.readFileSync('src/__tests__/media/test.jpeg', 'utf8');
    return Object.assign(
        {
            name: 'test',
            data: file,
            dataType: 'jpeg'
        },
    );
}

export async function givenMedia() {
    return new MediaRepository(testdb).create(givenMediaData());
}