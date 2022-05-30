import {Entity, model, property} from '@loopback/repository';

@model()
export class ExpertCategory extends Entity {
    @property({
        type: 'number',
        id: true,
        generated: true,
    })
    id?: number;

    @property({
        type: 'string',
        required: true,
        index: {
            unique: true,
        },
    })
    categoryName: string;

    constructor(data?: Partial<ExpertCategory>) {
        super(data);
    }
}

export interface ExpertCategoryRelations {
    // describe navigational properties here
}

export type ExpertCategoryWithRelations = ExpertCategory & ExpertCategoryRelations;
