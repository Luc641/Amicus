import {Entity, hasMany, hasOne, model, property} from '@loopback/repository';
import {AppUserExpertCategory} from './app-user-expert-category.model';
import {ExpertCategory} from './expert-category.model';
import {Media} from './media.model';
import {Request} from './request.model';

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
    "index": {"unique": true}
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
    "index": {"unique": true}
  })
  username: string;

  @hasMany(() => ExpertCategory, {through: {model: () => AppUserExpertCategory}})
  expertCategories: ExpertCategory[];

  @hasOne(() => Media)
  profilePicture: Media;

  @hasMany(() => Request, {keyTo: 'requesterId'})
  ownRequests: Request[];

  @hasMany(() => Request, {keyTo: 'expertId'})
  expertRequests: Request[];

  constructor(data?: Partial<AppUser>) {
    super(data);
  }
}

export interface AppUserRelations {
  // describe navigational properties here
}

export type AppUserWithRelations = AppUser & AppUserRelations;
