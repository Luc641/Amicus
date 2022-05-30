import {Entity, model, property, belongsTo, hasOne} from '@loopback/repository';
import {ExpertCategory} from './expert-category.model';
import {ExpertResponse} from './expert-response.model';
import {Media} from './media.model';

@model()
export class Request extends Entity {
  @property({
    type: 'number',
    id: true,
    generated: true,
  })
  id?: number;

  @property({
    type: 'string',
    required: true,
  })
  title: string;

  @property({
    type: 'string',
    required: true,
  })
  content: string;

  @property({
    type: 'date',
    jsonSchema: {
      format: 'date',
    },
  })
  date: string;

  @property({
    type: 'string',
  })
  location?: string;

  @property({
    type: 'boolean',
    required: true,
  })
  isOpen: boolean;

  @property({
    type: 'number',
  })
  requesterId?: number;

  @property({
    type: 'number',
  })
  expertId?: number;

  @belongsTo(() => ExpertCategory)
  expertCategoryId: number;

  @hasOne(() => ExpertResponse)
  expertResponse: ExpertResponse;

  @belongsTo(() => Media)
  mediaId: number;

  constructor(data?: Partial<Request>) {
    super(data);
  }
}

export interface RequestRelations {
    // describe navigational properties here
}

export type RequestWithRelations = Request & RequestRelations;
