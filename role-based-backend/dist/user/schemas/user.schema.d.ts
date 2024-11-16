import { Document } from 'mongoose';
export declare enum UserRole {
    Admin = "admin",
    User = "user",
    Agency = "agency"
}
export declare class User extends Document {
    name: string;
    username: string;
    email: string;
    password: string;
    role: UserRole;
    cause?: string;
    date?: string;
    time?: string;
    serviceLocation?: string;
    static _id: any;
}
export declare const UserSchema: import("mongoose").Schema<User, import("mongoose").Model<User, any, any, any, Document<unknown, any, User> & User & Required<{
    _id: unknown;
}> & {
    __v: number;
}, any>, {}, {}, {}, {}, import("mongoose").DefaultSchemaOptions, User, Document<unknown, {}, import("mongoose").FlatRecord<User>> & import("mongoose").FlatRecord<User> & Required<{
    _id: unknown;
}> & {
    __v: number;
}>;
