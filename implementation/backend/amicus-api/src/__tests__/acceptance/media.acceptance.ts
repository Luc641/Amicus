import {AmicusApiApplication} from '../..';
import {Client, createRestAppClient, expect} from '@loopback/testlab';
import {givenEmptyDatabase, givenMedia} from '../helpers/database.helpers';
import {testdb} from '../fixtures/datasources/testdb.datasource';

describe('AppUserController (acceptance)', () => {
    let app: AmicusApiApplication;
    let client: Client;

    before(givenEmptyDatabase);
    before(givenRunningApp);
    after(async () => {
        await app.stop();
    });

    it('retrieves media', async () => {
        const media = await givenMedia();

        const expected = Object.assign(media, {id: 1});
        const response = await client.get('/media/1');
        expect(Buffer.from(response.body.data)).to.containEql(expected.data);
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
