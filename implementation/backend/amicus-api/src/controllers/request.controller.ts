import {
    Count,
    CountSchema,
    Filter,
    FilterExcludingWhere,
    repository,
    Where,
} from '@loopback/repository';
import {
    post,
    param,
    get,
    getModelSchemaRef,
    patch,
    put,
    del,
    requestBody,
    response,
} from '@loopback/rest';
import {Request} from '../models';
import {MediaRepository, RequestRepository} from '../repositories';

export class RequestController {
    constructor(
        @repository(RequestRepository)
        public requestRepository: RequestRepository,
        @repository(MediaRepository)
        public mediaRepository: MediaRepository,
    ) {
    }

    @post('/requests')
    @response(200, {
        description: 'Request model instance',
        content: {'application/json': {schema: getModelSchemaRef(Request)}},
    })
    async create(
        @requestBody({
            content: {
                'application/json': {
                    schema: getModelSchemaRef(Request, {
                        title: 'NewRequest',
                        exclude: ['id'],
                    }),
                },
            },
        })
            request: Omit<Request, 'id'>,
    ): Promise<Request> {
        return this.requestRepository.create(request);
    }


    @get('/requests/categories')
    @response(200, {
        description: 'Return all open requests that match the provided category ids',
        content: {
            'application/json': {
                schema: getModelSchemaRef(Request, {includeRelations: true}),
            },
        },
    })
    async findByCategoryIds(
        @param.array('id', 'query', {type: 'number'}) categories: number[],
    ): Promise<Request[]> {
        return this.requestRepository.find({
            where: {expertCategoryId: {inq: categories}, isOpen: true},
            include: ['expertCategory'],
        });
    }

    @get('/requests/mine')
    @response(200, {
        description: 'Request model instance',
        content: {
            'application/json': {
                schema: getModelSchemaRef(Request, {includeRelations: true}),
            },
        },
    })
    async findMyRequests(
        @param.query.number('user_id') userId: number,
        @param.query.boolean('is_closed') isClosed: boolean,
    ): Promise<Request[]> {
        return this.requestRepository.find({
            where: {requesterId: userId, isOpen: !isClosed},
            include: ['expertCategory', 'expertResponse'],
        });
    }

    @get('/requests/expert')
    @response(200, {
        description: 'Request model instance',
        content: {
            'application/json': {
                schema: getModelSchemaRef(Request, {includeRelations: true}),
            },
        },
    })
    async findMyExpertAdviceRequests(
        @param.query.number('user_id') userId: number,
        @param.query.boolean('is_closed') isClosed: boolean,
    ): Promise<Request[]> {
        return this.requestRepository.find({
            where: {expertId: userId, isOpen: !isClosed},
            include: ['expertCategory', 'expertResponse'],
        });
    }

    @get('/requests/count')
    @response(200, {
        description: 'Request model count',
        content: {'application/json': {schema: CountSchema}},
    })
    async count(
        @param.where(Request) where?: Where<Request>,
    ): Promise<Count> {
        return this.requestRepository.count(where);
    }

    @get('/requests')
    @response(200, {
        description: 'Array of Request model instances',
        content: {
            'application/json': {
                schema: {
                    type: 'array',
                    items: getModelSchemaRef(Request, {includeRelations: true}),
                },
            },
        },
    })
    async find(
        @param.filter(Request) filter?: Filter<Request>,
    ): Promise<Request[]> {
        return this.requestRepository.find(filter);
    }

    @patch('/requests')
    @response(200, {
        description: 'Request PATCH success count',
        content: {'application/json': {schema: CountSchema}},
    })
    async updateAll(
        @requestBody({
            content: {
                'application/json': {
                    schema: getModelSchemaRef(Request, {partial: true}),
                },
            },
        })
            request: Request,
        @param.where(Request) where?: Where<Request>,
    ): Promise<Count> {
        return this.requestRepository.updateAll(request, where);
    }

    @get('/requests/{id}')
    @response(200, {
        description: 'Request model instance',
        content: {
            'application/json': {
                schema: getModelSchemaRef(Request, {includeRelations: true}),
            },
        },
    })
    async findById(
        @param.path.number('id') id: number,
        @param.filter(Request, {exclude: 'where'}) filter?: FilterExcludingWhere<Request>,
    ): Promise<Request> {
        return this.requestRepository.findById(id, filter);
    }

    @patch('/requests/{id}')
    @response(204, {
        description: 'Request PATCH success',
        content: {
            'application/json': {
                schema: getModelSchemaRef(Request),
            },
        },
    })
    async updateById(
        @param.path.number('id') id: number,
        @requestBody({
            content: {
                'application/json': {
                    schema: getModelSchemaRef(Request, {partial: true}),
                },
            },
        })
            request: Request,
    ): Promise<Request> {
        await this.requestRepository.updateById(id, request);
        return request;
    }

    @put('/requests/{id}')
    @response(204, {
        description: 'Request PUT success',
    })
    async replaceById(
        @param.path.number('id') id: number,
        @requestBody() request: Request,
    ): Promise<void> {
        await this.requestRepository.replaceById(id, request);
    }

    @del('/requests/{id}')
    @response(204, {
        description: 'Request DELETE success',
    })
    async deleteById(@param.path.number('id') id: number): Promise<void> {
        await this.requestRepository.deleteById(id);
    }
}
