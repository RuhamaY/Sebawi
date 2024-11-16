import { Document } from 'mongoose';
import { Posts } from "src/posts/schemas/posts.schema";
import { User } from "src/user/schemas/user.schema";
import mongoose from "mongoose";
export declare class Calendars {
    user: User;
    post: Posts;
    date: Date;
}
export declare const CalendarsSchema: mongoose.Schema<Calendars, mongoose.Model<Calendars, any, any, any, Document<unknown, any, Calendars> & Calendars & {
    _id: mongoose.Types.ObjectId;
} & {
    __v: number;
}, any>, {}, {}, {}, {}, mongoose.DefaultSchemaOptions, Calendars, Document<unknown, {}, mongoose.FlatRecord<Calendars>> & mongoose.FlatRecord<Calendars> & {
    _id: mongoose.Types.ObjectId;
} & {
    __v: number;
}>;
