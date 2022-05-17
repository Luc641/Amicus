import {AmicusApiApplication} from '../..';
import {Client, createRestAppClient, expect} from '@loopback/testlab';
import {givenEmptyDatabase, givenExpertCategory, givenUserCategory} from '../helpers/database.helpers';
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
        await givenUserCategory(1);
        const category = await givenExpertCategory('Dentist');
        const expected = Object.assign(category, {id: 1});

        const response = await client.get('/app-users/1/expert-categories').expect(200);
        expect(response.body[0]).to.containEql(expected);
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
