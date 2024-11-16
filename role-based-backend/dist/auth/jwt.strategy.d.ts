import { Model } from "mongoose";
import { User } from "../user/schemas/user.schema";
declare const JwtStrategy_base: new (...args: any[]) => any;
export declare class JwtStrategy extends JwtStrategy_base {
    private userModel;
    constructor(userModel: Model<User>);
    validate(payload: any): Promise<import("mongoose").Document<unknown, {}, User> & User & Required<{
        _id: unknown;
    }> & {
        __v: number;
    }>;
}
declare const AdminStrategy_base: new (...args: any[]) => any;
export declare class AdminStrategy extends AdminStrategy_base {
    constructor();
    validate(payload: any): Promise<any>;
}
declare const UserRoleStrategy_base: new (...args: any[]) => any;
export declare class UserRoleStrategy extends UserRoleStrategy_base {
    constructor();
    validate(payload: any): Promise<any>;
}
declare const AgencyRoleStrategy_base: new (...args: any[]) => any;
export declare class AgencyRoleStrategy extends AgencyRoleStrategy_base {
    constructor();
    validate(payload: any): Promise<any>;
}
export {};
