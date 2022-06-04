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
import {Media} from '../models';
import {MediaRepository} from '../repositories';
import {authenticate} from '@loopback/authentication';

export class MediaController {
  constructor(
    @repository(MediaRepository)
    public mediaRepository: MediaRepository,
  ) {
  }

  // Endpoint to add new media to the db
  @authenticate('jwt')
  @post('/media')
  @response(200, {
    description: 'Media model instance',
    content: {'application/json': {schema: getModelSchemaRef(Media)}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Media, { //Create media object out of the request body
            title: 'NewMedia',
            exclude: ['id'],
          }),
        },
      },
    })
      media: Omit<Media, 'id'>,
  ): Promise<Media> {
    return this.mediaRepository.create(media);
  }

  // Endpoint to retrieve the media matching the given media id
  @authenticate('jwt')
  @get('/media/{id}')
  @response(200, {
    description: 'Media model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(Media, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.number('id') id: number, //Retrieve id from url 
    @param.filter(Media, {exclude: 'where'}) filter?: FilterExcludingWhere<Media>,
  ): Promise<Media> {
    return this.mediaRepository.findById(id, filter);
  }

  // // Endpoint to get the amount of media matching a condition
  // @authenticate('jwt')
  // @get('/media/count')
  // @response(200, {
  //   description: 'Media model count',
  //   content: {'application/json': {schema: CountSchema}},
  // })
  // async count(
  //   @param.where(Media) where?: Where<Media>, //Get the matching condition from the request
  // ): Promise<Count> {
  //   return this.mediaRepository.count(where);
  // }

  // // Endpoint to get all the media matching  a condition
  // @authenticate('jwt')
  // @get('/media')
  // @response(200, {
  //   description: 'Array of Media model instances',
  //   content: {
  //     'application/json': {
  //       schema: {
  //         type: 'array',
  //         items: getModelSchemaRef(Media, {includeRelations: true}),
  //       },
  //     },
  //   },
  // })
  // async find(
  //   @param.filter(Media) filter?: Filter<Media>, //Get the matching condition from the request
  // ): Promise<Media[]> {
  //   return this.mediaRepository.find(filter);
  // }

  // // Endpoint to replace a certain media by another one given the media id
  // @authenticate('jwt')
  // @put('/media/{id}')
  // @response(204, {
  //   description: 'Media PUT success',
  // })
  // async replaceById(
  //   @param.path.number('id') id: number, //Retrieve media id to replace from url
  //   @requestBody() media: Media, //Create new media object from the request body
  // ): Promise<void> {
  //   await this.mediaRepository.replaceById(id, media);
  // }



  // // Endpoint to delete a certain media from the db given the media id
  // @authenticate('jwt')
  // @del('/media/{id}')
  // @response(204, {
  //   description: 'Media DELETE success',
  // })
  // async deleteById(@param.path.number('id') id: number): Promise<void> { //Retrieve media id from url
  //   await this.mediaRepository.deleteById(id);
  // }

  // // Endpoint to update all the media matching a condition
  // @authenticate('jwt')
  // @patch('/media')
  // @response(200, {
  //   description: 'Media PATCH success count',
  //   content: {'application/json': {schema: CountSchema}},
  // })
  // async updateAll(
  //   @requestBody({
  //     content: {
  //       'application/json': {
  //         schema: getModelSchemaRef(Media, {partial: true}), //Allow media object creation without some fields
  //       },
  //     },
  //   })
  //     media: Media,
  //   @param.where(Media) where?: Where<Media>, //Get the matching condition from the request
  // ): Promise<Count> {
  //   return this.mediaRepository.updateAll(media, where); 
  // }

  // // Endpoint to update the media fields for the given media id
  // @authenticate('jwt')
  // @patch('/media/{id}')
  // @response(204, {
  //   description: 'Media PATCH success',
  // })
  // async updateById(
  //   @param.path.number('id') id: number, //Retrieve the id from the url
  //   @requestBody({
  //     content: {
  //       'application/json': {
  //         schema: getModelSchemaRef(Media, {partial: true}), //Allow media object creation without some fields
  //       },
  //     },
  //   })
  //     media: Media,
  // ): Promise<void> {
  //   await this.mediaRepository.updateById(id, media);
  // }
}
