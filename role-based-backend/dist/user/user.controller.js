"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserController = void 0;
const common_1 = require("@nestjs/common");
const passport_1 = require("@nestjs/passport");
const user_schema_1 = require("./schemas/user.schema");
const user_service_1 = require("./user.service");
let UserController = class UserController {
    constructor(userService) {
        this.userService = userService;
    }
    async deleteUser(userId) {
        await this.userService.deleteUser(userId);
        return { message: "User deleted successfully." };
    }
    async getUser(id) {
        return this.userService.findById(id);
    }
    async getAllUsers() {
        return this.userService.getAllUsers();
    }
    async updateUserRole(userId, newRole) {
        await this.userService.updateUserRole(userId, newRole);
        return { message: 'Role updated successfully' };
    }
    async updateUserProfile(userId, username, password, cause, date, time, serviceLocation) {
        await this.userService.updateUserProfile(userId, username, password, cause, date, time, serviceLocation);
        return { message: 'Profile updated successfully' };
    }
    async deleteUserAccount(userId) {
        await this.userService.deleteUserAccount(userId);
        return { message: 'Account deleted successfully' };
    }
};
exports.UserController = UserController;
__decorate([
    (0, common_1.Delete)(':id'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('admin')),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "deleteUser", null);
__decorate([
    (0, common_1.Get)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "getUser", null);
__decorate([
    (0, common_1.Get)(),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('admin')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], UserController.prototype, "getAllUsers", null);
__decorate([
    (0, common_1.Patch)(':id/role'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('admin')),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)('role')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "updateUserRole", null);
__decorate([
    (0, common_1.Patch)(':id/profile'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('user')),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)('username')),
    __param(2, (0, common_1.Body)('password')),
    __param(3, (0, common_1.Body)('cause')),
    __param(4, (0, common_1.Body)('date')),
    __param(5, (0, common_1.Body)('time')),
    __param(6, (0, common_1.Body)('serviceLocation')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String, String, String, String, String, String]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "updateUserProfile", null);
__decorate([
    (0, common_1.Delete)(':id/account'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('user')),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "deleteUserAccount", null);
exports.UserController = UserController = __decorate([
    (0, common_1.Controller)('user'),
    __metadata("design:paramtypes", [user_service_1.UserService])
], UserController);
//# sourceMappingURL=user.controller.js.map