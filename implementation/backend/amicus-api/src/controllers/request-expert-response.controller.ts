import {
    Count,
    CountSchema,
    Filter,
    repository,
    Where,
} from '@loopback/repository';
import {
    del,
    get,
    getModelSchemaRef,
    getWhereSchemaFor,
    param,
    patch,
    post,
    requestBody,
} from '@loopback/rest';
import {
    Request,
    ExpertResponse,
} from '../models';
import {RequestRepository} from '../repositories';

export class RequestExpertResponseController {
    constructor(
        @repository(RequestRepository) protected requestRepository: RequestRepository,
    ) {
    }

    // @get('/requests/{id}/expert-response', {
    //     responses: {
    //         '200': {
    //             description: 'Request has one ExpertResponse',
    //             content: {
    //                 'application/json': {
    //                     schema: getModelSchemaRef(ExpertResponse),
    //                 },
    //             },
    //         },
    //     },
    // })
    // async get(
    //     @param.path.number('id') id: number,
    //     @param.query.object('filter') filter?: Filter<ExpertResponse>,
    // ): Promise<ExpertResponse> {
    //     return this.requestRepository.expertResponse(id).get(filter);
    // }

    // @post('/requests/{id}/expert-response', {
    //     responses: {
    //         '200': {
    //             description: 'Request model instance',
    //             content: {'application/json': {schema: getModelSchemaRef(ExpertResponse)}},
    //         },
    //     },
    // })
    // async create(
    //     @param.path.number('id') id: typeof Request.prototype.id,
    //     @requestBody({
    //         content: {
    //             'application/json': {
    //                 schema: getModelSchemaRef(ExpertResponse, {
    //                     title: 'NewExpertResponseInRequest',
    //                     exclude: ['id'],
    //                     optional: ['requestId'],
    //                 }),
    //             },
    //         },
    //     }) expertResponse: Omit<ExpertResponse, 'id'>,
    // ): Promise<ExpertResponse> {
    //     return this.requestRepository.expertResponse(id).create(expertResponse);
    // }

    // @patch('/requests/{id}/expert-response', {
    //     responses: {
    //         '200': {
    //             description: 'Request.ExpertResponse PATCH success count',
    //             content: {'application/json': {schema: CountSchema}},
    //         },
    //     },
    // })
    // async patch(
    //     @param.path.number('id') id: number,
    //     @requestBody({
    //         content: {
    //             'application/json': {
    //                 schema: getModelSchemaRef(ExpertResponse, {partial: true}),
    //             },
    //         },
    //     })
    //         expertResponse: Partial<ExpertResponse>,
    //     @param.query.object('where', getWhereSchemaFor(ExpertResponse)) where?: Where<ExpertResponse>,
    // ): Promise<Count> {
    //     return this.requestRepository.expertResponse(id).patch(expertResponse, where);
    // }

    // @del('/requests/{id}/expert-response', {
    //     responses: {
    //         '200': {
    //             description: 'Request.ExpertResponse DELETE success count',
    //             content: {'application/json': {schema: CountSchema}},
    //         },
    //     },
    // })
    // async delete(
    //     @param.path.number('id') id: number,
    //     @param.query.object('where', getWhereSchemaFor(ExpertResponse)) where?: Where<ExpertResponse>,
    // ): Promise<Count> {
    //     return this.requestRepository.expertResponse(id).delete(where);
    // }
}
