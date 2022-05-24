import {BootMixin} from '@loopback/boot';
import {ApplicationConfig} from '@loopback/core';
import {
    RestExplorerBindings,
    RestExplorerComponent,
} from '@loopback/rest-explorer';
import {RepositoryMixin} from '@loopback/repository';
import {RestApplication, RestBindings} from '@loopback/rest';
import {ServiceMixin} from '@loopback/service-proxy';
import path from 'path';
import {MySequence} from './sequence';

import {AuthenticationComponent} from '@loopback/authentication';
import {
    JWTAuthenticationComponent,
    UserServiceBindings,
} from '@loopback/authentication-jwt';
import {AmicusDatabaseDataSource} from './datasources';
import {AppUserService} from './services/app-user.service';
import {AppUserServiceBindings} from './bindings/app-user-service.bindings';
import {format, LoggingBindings, LoggingComponent} from '@loopback/logging';

export {ApplicationConfig};


export class AmicusApiApplication extends BootMixin(
    ServiceMixin(RepositoryMixin(RestApplication)),
) {
    constructor(options: ApplicationConfig = {}) {
        super(options);

        // Overwritten to support avatar and image uploads
        this.bind(RestBindings.REQUEST_BODY_PARSER_OPTIONS).to({
            json: {limit: '100MB'},
            text: {limit: '100MB'},
        });
        // Mount authentication system
        this.component(AuthenticationComponent);
        // Mount jwt component
        this.component(JWTAuthenticationComponent);
        // Enable logging
        this.configure(LoggingBindings.COMPONENT).to({
            enableFluent: false,
            enableHttpAccessLog: true,
        });

        this.configure(LoggingBindings.WINSTON_LOGGER).to({
            level: 'info',
            format: format.json(),
            defaultMeta: {framework: 'LoopBack'},
        });

        this.configure(LoggingBindings.WINSTON_HTTP_ACCESS_LOGGER).to({});
        this.component(LoggingComponent);
        // Bind datasource
        this.dataSource(AmicusDatabaseDataSource, UserServiceBindings.DATASOURCE_NAME);

        this.bind(AppUserServiceBindings.USER_SERVICE).toClass(AppUserService);
        // Set up the custom sequence
        this.sequence(MySequence);

        // Set up default home page
        this.static('/', path.join(__dirname, '../public'));

        // Customize @loopback/rest-explorer configuration here
        this.configure(RestExplorerBindings.COMPONENT).to({
            path: '/explorer',
        });
        this.component(RestExplorerComponent);

        this.projectRoot = __dirname;
        // Customize @loopback/boot Booter Conventions here
        this.bootOptions = {
            controllers: {
                // Customize ControllerBooter Conventions here
                dirs: ['controllers'],
                extensions: ['.controller.js'],
                nested: true,
            },
        };
    }
}
