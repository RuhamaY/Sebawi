/// <reference types="mongoose/types/aggregate" />
/// <reference types="mongoose/types/callback" />
/// <reference types="mongoose/types/collection" />
/// <reference types="mongoose/types/connection" />
/// <reference types="mongoose/types/cursor" />
/// <reference types="mongoose/types/document" />
/// <reference types="mongoose/types/error" />
/// <reference types="mongoose/types/expressions" />
/// <reference types="mongoose/types/helpers" />
/// <reference types="mongoose/types/middlewares" />
/// <reference types="mongoose/types/indexes" />
/// <reference types="mongoose/types/models" />
/// <reference types="mongoose/types/mongooseoptions" />
/// <reference types="mongoose/types/pipelinestage" />
/// <reference types="mongoose/types/populate" />
/// <reference types="mongoose/types/query" />
/// <reference types="mongoose/types/schemaoptions" />
/// <reference types="mongoose/types/schematypes" />
/// <reference types="mongoose/types/session" />
/// <reference types="mongoose/types/types" />
/// <reference types="mongoose/types/utility" />
/// <reference types="mongoose/types/validation" />
/// <reference types="mongoose/types/virtuals" />
/// <reference types="mongoose/types/inferschematype" />
/// <reference types="mongoose/types/inferrawdoctype" />
import { CreateCalendarDto } from './dto/create-calendar.dto';
import { UpdateCalendarDto } from './dto/update-calendar.dto';
import { Model } from 'mongoose';
import { Calendars } from './schema/calendar.schema';
import { User } from 'src/user/schemas/user.schema';
export declare class CalendarsService {
    private readonly calendarsModel;
    constructor(calendarsModel: Model<Calendars>);
    createEvent(createEventDto: CreateCalendarDto, postId: string, user: User): Promise<Calendars>;
    findAllByUser(userId: string): Promise<Calendars[]>;
    findAllByPost(postId: string): Promise<(import("mongoose").Document<unknown, {}, Calendars> & Calendars & {
        _id: import("mongoose").Types.ObjectId;
    } & {
        __v?: number;
    })[]>;
    findOne(id: number): string;
    update(id: number, updateCalendarDto: UpdateCalendarDto): string;
    remove(id: number): string;
}
