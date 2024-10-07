import { Controller, Delete, Get, Param, UseGuards, Patch, Body } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { User, UserRole } from './schemas/user.schema';
import { UserService } from './user.service';


@Controller('user')
export class UserController {
    constructor(private readonly userService: UserService) { }

    @Delete(':id')
    @UseGuards(AuthGuard('admin'))
    async deleteUser(@Param('id') userId: string): Promise<{message: string}> {
        await this.userService.deleteUser(userId);
        return {message: "User deleted successfully."}
    }


    @Get(':id')
    async getUser(
        @Param('id')
        id: string
    ): Promise<User> {
        return this.userService.findById(id);
    }

    @Get()
    @UseGuards(AuthGuard('admin'))
    async getAllUsers(): Promise<User[]> {
        return this.userService.getAllUsers();
    }

    
    @Patch(':id/role')
    @UseGuards(AuthGuard('admin'))
    async updateUserRole(
        @Param('id') userId: string,
        @Body('role') newRole: UserRole,
    ): Promise<{ message: string }> {
        await this.userService.updateUserRole(userId, newRole);
        return { message: 'Role updated successfully' };
    }

    @Patch(':id/profile')
    @UseGuards(AuthGuard('user'))
    async updateUserProfile(
        @Param('id') userId: string,
        @Body('username') username: string,
        @Body('password') password: string,
        @Body('cause') cause?: string,
        @Body('date') date?: string,
        @Body('time') time?: string,
        @Body('serviceLocation') serviceLocation?: string
    ): Promise<{ message: string }> {
        await this.userService.updateUserProfile(userId, username, password, cause, date, time, serviceLocation);
        return { message: 'Profile updated successfully' };
    }   

    @Delete(':id/account')
    @UseGuards(AuthGuard('user'))
    async deleteUserAccount(@Param('id') userId: string): Promise<{ message: string }> {
        await this.userService.deleteUserAccount(userId);
        return { message: 'Account deleted successfully' };
    }
}



