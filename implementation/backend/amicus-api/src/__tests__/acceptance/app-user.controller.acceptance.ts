import {AmicusApiApplication} from '../..';
import {Client, createRestAppClient, expect} from '@loopback/testlab';
import {givenEmptyDatabase, givenAppUser} from '../helpers/database.helpers';
import {testdb} from '../fixtures/datasources/testdb.datasource';

describe('AppUserController (acceptance)', () => {
    let app: AmicusApiApplication;
    let client: Client;

    before(givenEmptyDatabase);
    before(givenRunningApp);
    after(async () => {
        await app.stop();
    });

    it('retrieves app user', async () => {
        const appUser = await givenAppUser({
            firstName: "Abc",
            lastName: "Def",
        });

        const expected = Object.assign(appUser, {id: 1, birthDate: undefined});
        const response = await client.get('/users/1');
        response.body.birthDate = undefined
        expect(response.body).to.containEql(expected);
    });

    async function givenRunningApp() {
        app = new AmicusApiApplication({
            rest: {
                port: 0,
            },
        });
        await app.boot();
        app.dataSource(testdb);
        await app.start();

        client = createRestAppClient(app);
    }
});
