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
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserSchema = exports.User = exports.UserRole = void 0;
const mongoose_1 = require("@nestjs/mongoose");
const mongoose_2 = require("mongoose");
var UserRole;
(function (UserRole) {
    UserRole["Admin"] = "admin";
    UserRole["User"] = "user";
    UserRole["Agency"] = "agency";
})(UserRole || (exports.UserRole = UserRole = {}));
let User = class User extends mongoose_2.Document {
};
exports.User = User;
__decorate([
    (0, mongoose_1.Prop)({ required: true }),
    __metadata("design:type", String)
], User.prototype, "name", void 0);
__decorate([
    (0, mongoose_1.Prop)({ unique: true, required: true }),
    __metadata("design:type", String)
], User.prototype, "username", void 0);
__decorate([
    (0, mongoose_1.Prop)({ unique: true, required: true }),
    __metadata("design:type", String)
], User.prototype, "email", void 0);
__decorate([
    (0, mongoose_1.Prop)(),
    __metadata("design:type", String)
], User.prototype, "password", void 0);
__decorate([
    (0, mongoose_1.Prop)(),
    __metadata("design:type", String)
], User.prototype, "role", void 0);
__decorate([
    (0, mongoose_1.Prop)({
        required: function () {
            return this.role === UserRole.Agency;
        },
    }),
    __metadata("design:type", String)
], User.prototype, "cause", void 0);
__decorate([
    (0, mongoose_1.Prop)({
        required: function () {
            return this.role === UserRole.Agency;
        },
    }),
    __metadata("design:type", String)
], User.prototype, "date", void 0);
__decorate([
    (0, mongoose_1.Prop)({
        required: function () {
            return this.role === UserRole.Agency;
        },
    }),
    __metadata("design:type", String)
], User.prototype, "time", void 0);
__decorate([
    (0, mongoose_1.Prop)({
        required: function () {
            return this.role === UserRole.Agency;
        },
    }),
    __metadata("design:type", String)
], User.prototype, "serviceLocation", void 0);
exports.User = User = __decorate([
    (0, mongoose_1.Schema)({
        timestamps: true,
    })
], User);
exports.UserSchema = mongoose_1.SchemaFactory.createForClass(User);
//# sourceMappingURL=user.schema.js.map