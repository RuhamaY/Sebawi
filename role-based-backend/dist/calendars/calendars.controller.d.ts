import { CalendarsService } from './calendars.service';
import { CreateCalendarDto } from './dto/create-calendar.dto';
import { UpdateCalendarDto } from './dto/update-calendar.dto';
import { Calendars } from './schema/calendar.schema';
export declare class CalendarsController {
    private readonly calendarsService;
    constructor(calendarsService: CalendarsService);
    createEvent(postId: string, createEventDto: CreateCalendarDto, req: any): Promise<Calendars>;
    findAllByUser(req: any): Promise<Calendars[]>;
    findOne(id: string): string;
    findAllByPost(postId: string): Promise<(import("mongoose").Document<unknown, {}, Calendars> & Calendars & {
        _id: import("mongoose").Types.ObjectId;
    } & {
        __v: number;
    })[]>;
    update(id: string, updateCalendarDto: UpdateCalendarDto): string;
    remove(id: string): string;
}
