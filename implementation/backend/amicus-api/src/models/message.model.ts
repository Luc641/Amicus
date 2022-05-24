import {Entity, hasMany, model, property} from '@loopback/repository';
import {Media, MediaWithRelations} from './media.model';
import {Request, RequestWithRelations} from './request.model';

@model()
export class Message extends Entity {
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
  content: string;

  @property({
    type: 'date',
    required: true,
  })
  date: string;

  @property({
    type: 'number',
    required: true,
  })
  appUserId: number;

  @hasMany(() => Media)
  media?: Media[];

  @property(() => Request)
  requestId?: number;

  constructor(data?: Partial<Message>) {
    super(data);
  }
}

export interface MessageRelations {
  media?: MediaWithRelations[]
  request?: RequestWithRelations
}

export type MessageWithRelations = Message & MessageRelations;
