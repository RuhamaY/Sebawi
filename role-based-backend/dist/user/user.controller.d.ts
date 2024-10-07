import { User, UserRole } from './schemas/user.schema';
import { UserService } from './user.service';
export declare class UserController {
    private readonly userService;
    constructor(userService: UserService);
    deleteUser(userId: string): Promise<{
        message: string;
    }>;
    getUser(id: string): Promise<User>;
    getAllUsers(): Promise<User[]>;
    updateUserRole(userId: string, newRole: UserRole): Promise<{
        message: string;
    }>;
    updateUserProfile(userId: string, username: string, password: string, cause?: string, date?: string, time?: string, serviceLocation?: string): Promise<{
        message: string;
    }>;
    deleteUserAccount(userId: string): Promise<{
        message: string;
    }>;
}
