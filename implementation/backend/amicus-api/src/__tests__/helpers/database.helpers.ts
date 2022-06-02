import {
    AppUserRepository,
    MediaRepository,
    ExpertCategoryRepository,
    AppUserExpertCategoryRepository,
    RequestRepository, ExpertResponseRepository, DeviceTokenRepository,
} from '../../repositories';
import {testdb} from '../fixtures/datasources/testdb.datasource';
import {AppUser} from '../../models';
import * as fs from 'fs';
import {Getter} from '@loopback/context';


const appUserExpertCategoryRepository = new AppUserExpertCategoryRepository(testdb);
const expertCategoryRepository = new ExpertCategoryRepository(testdb);
const mediaRepository = new MediaRepository(testdb);
const expertResponseRepository = new ExpertResponseRepository(testdb);
const deviceRepository = new DeviceTokenRepository(testdb);
const requestRepository = new RequestRepository(
    testdb,
    Getter.fromValue(expertCategoryRepository),
    Getter.fromValue(expertResponseRepository),
    Getter.fromValue(mediaRepository));
const appUserRepository = new AppUserRepository(testdb,
    Getter.fromValue(appUserExpertCategoryRepository),
    Getter.fromValue(expertCategoryRepository),
    Getter.fromValue(mediaRepository), Getter.fromValue(requestRepository),
    Getter.fromValue(deviceRepository));


export async function givenEmptyDatabase() {
    await appUserRepository.deleteAll();
    await mediaRepository.deleteAll();
    await appUserExpertCategoryRepository.deleteAll();
    await expertCategoryRepository.deleteAll();
}

export function givenAppUserData(data?: Partial<AppUser>) {
    return Object.assign(
        {
            firstName: 'Friendly',
            lastName: 'Person',
            email: 'friendly@person.com',
            birthDate: new Date(628021800000),
            address: 'Venlo',
            passwordHash: 'supersecurepassword',
            username: 'amicus_user',
        },
        data,
    );
}

export async function givenAppUser(data?: Partial<AppUser>) {
    return appUserRepository.create(givenAppUserData(data));
}

export function givenMediaData() {
    const file = fs.readFileSync('src/__tests__/media/test.jpeg', 'utf8');
    return Object.assign(
        {
            name: 'test',
            data: file,
            dataType: 'jpeg',
        },
    );
}

export function givenRequestData() {
    return Object.assign(
        {
            title: 'Title Test',
            content: 'Content Test',
            date: new Date(2022, 5, 20),
            location: 'Venlo',
            isOpen: true,
        },
    );
}

export async function givenMedia() {
    return mediaRepository.create(givenMediaData());
}

export function givenExpertCategoryData(name: String) {
    return Object.assign(
        {
            categoryName: name,
        },
    );
}

export async function givenExpertCategory(name: String) {
    return new ExpertCategoryRepository(testdb).create(givenExpertCategoryData(name));
}

export async function givenUserCategory(userId: number) {
    const category = await givenExpertCategory('Dentist');
    const expertCategory = Object.assign(category, {id: 1});
    return appUserRepository.expertCategories(userId).link(expertCategory.getId());
}

export async function givenRequest(id: number) {
    // return appUserRepository.requests(id).create(givenRequestData());
}
