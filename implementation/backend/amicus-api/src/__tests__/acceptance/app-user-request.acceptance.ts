import {Client, createRestAppClient, expect} from '@loopback/testlab';
import {AmicusApiApplication} from '../..';
import {testdb} from '../fixtures/datasources/testdb.datasource';
import {givenEmptyDatabase, givenRequest} from '../helpers/database.helpers';

describe('RequestController (acceptance)', () => {
  let app: AmicusApiApplication;
  let client: Client;

  before(givenEmptyDatabase);
  before(givenRunningApp);
  after(async () => {
    await app.stop();
  });

  it('retrieves request', async () => {
    const request = await givenRequest(1);

    const expected = Object.assign(request, {id: 1, date: undefined});
    const response = await client.get('/requests/1');
    response.body.date = undefined
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
