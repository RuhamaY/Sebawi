import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User, UserRole } from './schemas/user.schema';
import { Posts } from 'src/posts/schemas/posts.schema';

@Injectable()
export class UserService {

    // findByUsername(value: any) {
    //     throw new Error('Method not implemented.');
    // }
    constructor(
        @InjectModel('user') private readonly userModel: Model<User>,
    ) {}

    async findByUsername(username: string): Promise<User> {
        return this.userModel.findOne({username}).exec();
    }

    async getAllUsers(): Promise<User[]> {
        const users = await this.userModel.find().exec();
        return users;
    }


    async findById(id: String): Promise<User> {
        const user = (await this.userModel.findById(id));
        if(!user) {
            throw new NotFoundException('User not found');
        }
        return user
    }

    async deleteUser(userId: string): Promise<void> {
        const result = await this.userModel.deleteOne({ _id: userId }).exec();
        if (result.deletedCount === 0) {
            throw new NotFoundException('User not found');
        }
    }

    async updateUserRole(userId: string, newRole: UserRole): Promise<User> {
        if (!Object.values(UserRole).includes(newRole)) {
            throw new BadRequestException('Invalid role');
        }

        const user = await this.userModel.findById(userId).exec();
        if (!user) {
            throw new NotFoundException('User not found');
        }

        user.role = newRole;
        return user.save();
    }

    async updateUserProfile(userId: string, username: string, password: string, cause?: string, date?: string, time?: string, serviceLocation?: string): Promise<User> {
        const user = await this.userModel.findById(userId);
        if (!user) {
            throw new NotFoundException('User not found');
        }

        user.username = username;
        
        if (password) {
            user.password = password;
        }

        // Update agency-specific fields only if the user is an agency
        if (user.role === UserRole.Agency) {
            if (cause) user.cause = cause;
            if (date) user.date = date;
            if (time) user.time = time;
            if (serviceLocation) user.serviceLocation = serviceLocation;
        }

        return user.save();
    }

    async deleteUserAccount(userId: string): Promise<void> {
        const result = await this.userModel.deleteOne({ _id: userId }).exec();
        if (result.deletedCount === 0) {
            throw new NotFoundException('User not found');
        }
    }

}

