import {Entity, model, property} from '@loopback/repository';

@model()
export class AppUserExpertCategory extends Entity {
  @property({
    type: 'number',
    id: true,
    generated: true,
  })
  id?: number;

  @property({
    type: 'number',
    required: true,
  })
  appUserId: number;

  @property({
    type: 'number',
    required: true,
  })
  expertCategoryId: number;


  constructor(data?: Partial<AppUserExpertCategory>) {
    super(data);
  }
}

export interface AppUserExpertCategoryRelations {
  // describe navigational properties here
}

export type AppUserExpertCategoryWithRelations = AppUserExpertCategory & AppUserExpertCategoryRelations;
