import {Entity, model, property, hasMany} from '@loopback/repository';
import {ExpertCategory} from './expert-category.model';
import {AppUserExpertCategory} from './app-user-expert-category.model';

@model()
export class AppUser extends Entity {
  @property({
    type: 'string',
    required: true,
  })
  firstName: string;

  @property({
    type: 'string',
  })
  lastName?: string;

  @property({
    type: 'string',
    required: true,
  })
  email: string;

  @property({
    type: 'number',
    id: true,
    generated: true,
  })
  id: number;

  @property({
    type: 'date',
    jsonSchema: {
      format: 'date', //This can be changed to 'date-time', 'time' or 'date'
    },
  })
  birthDate?: string;

  @property({
    type: 'string',
  })
  address?: string;

  @property({
    type: 'string',
    required: true,
  })
  passwordHash: string;

  @property({
    type: 'string',
    required: true,
  })
  username: string;

  @hasMany(() => ExpertCategory, {through: {model: () => AppUserExpertCategory}})
  expertCategories: ExpertCategory[];

  constructor(data?: Partial<AppUser>) {
    super(data);
  }
}

export interface AppUserRelations {
  // describe navigational properties here
}

export type AppUserWithRelations = AppUser & AppUserRelations;
