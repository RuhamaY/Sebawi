import { Model } from 'mongoose';
import { User, UserRole } from './schemas/user.schema';
export declare class UserService {
    private readonly userModel;
    constructor(userModel: Model<User>);
    findByUsername(username: string): Promise<User>;
    getAllUsers(): Promise<User[]>;
    findById(id: String): Promise<User>;
    deleteUser(userId: string): Promise<void>;
    updateUserRole(userId: string, newRole: UserRole): Promise<User>;
    updateUserProfile(userId: string, username: string, password: string, cause?: string, date?: string, time?: string, serviceLocation?: string): Promise<User>;
    deleteUserAccount(userId: string): Promise<void>;
}
