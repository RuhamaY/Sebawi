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
        __v: number;
    })[]>;
    findOne(id: number): string;
    update(id: number, updateCalendarDto: UpdateCalendarDto): string;
    remove(id: number): string;
}
