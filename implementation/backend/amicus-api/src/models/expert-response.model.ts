import {Entity, model, property} from '@loopback/repository';

@model()
export class ExpertResponse extends Entity {
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
    jsonSchema: {
      format: 'date',
    },
  })
  date: string;

  @property({
    type: 'number',
  })
  requestId: number;

  constructor(data?: Partial<ExpertResponse>) {
    super(data);
  }
}

export interface ExpertResponseRelations {
    // describe navigational properties here
}

export type ExpertResponseWithRelations = ExpertResponse & ExpertResponseRelations;
