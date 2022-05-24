import {Entity, model, property} from '@loopback/repository';
import {Message, MessageWithRelations} from './message.model';
import {Request, RequestWithRelations} from './request.model';

@model()
export class Media extends Entity {
  @property({
    type: 'string',
    required: true,
  })
  name: string;

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
  data: string;

  @property({
    type: 'string',
    required: true,
  })
  dataType: string;

  @property({
    type: 'number',
  })
  appUserId?: number;
  @property(() => Request)
  requestId?: number;

  @property(() => Message)
  messageId?: number;


  constructor(data?: Partial<Media>) {
    super(data);
  }
}

export interface MediaRelations {
  // describe navigational properties here
  request?: RequestWithRelations
  message?: MessageWithRelations
}

export type MediaWithRelations = Media & MediaRelations;
