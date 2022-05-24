import {Entity, hasMany, model, property} from '@loopback/repository';
import {Media, MediaWithRelations} from './media.model';
import {Message, MessageWithRelations} from './message.model';

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
    required: true,
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
  appUserId?: number;

  @hasMany(() => Media)
  media?: Media[];

  @hasMany(() => Message)
  message?: Message[];

  constructor(data?: Partial<Request>) {
    super(data);
  }
}

export interface RequestRelations {
  // describe navigational properties here
  media?: MediaWithRelations[]
  message?: MessageWithRelations[]
}

export type RequestWithRelations = Request & RequestRelations;
