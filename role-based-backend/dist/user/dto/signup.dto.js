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
exports.SignUpDto = exports.IsUniqueConstraint = void 0;
exports.IsUnique = IsUnique;
const class_validator_1 = require("class-validator");
const user_service_1 = require("../user.service");
const common_1 = require("@nestjs/common");
let IsUniqueConstraint = class IsUniqueConstraint {
    constructor(userService) {
        this.userService = userService;
    }
    async validate(value) {
        console.log('UserService:', this.userService);
        const user = await this.userService.findByUsername(value);
        console.log('UserService:', this.userService);
        return !user;
    }
    defaultMessage() {
        return 'Username is already taken';
    }
};
exports.IsUniqueConstraint = IsUniqueConstraint;
exports.IsUniqueConstraint = IsUniqueConstraint = __decorate([
    (0, common_1.Injectable)(),
    (0, class_validator_1.ValidatorConstraint)({ async: true }),
    __metadata("design:paramtypes", [user_service_1.UserService])
], IsUniqueConstraint);
function IsUnique(validationOptions) {
    return function (object, propertyName) {
        (0, class_validator_1.registerDecorator)({
            name: 'isUnique',
            target: object.constructor,
            propertyName: propertyName,
            options: validationOptions,
            validator: IsUniqueConstraint,
        });
    };
}
class SignUpDto {
}
exports.SignUpDto = SignUpDto;
__decorate([
    (0, class_validator_1.IsNotEmpty)(),
    (0, class_validator_1.IsString)(),
    __metadata("design:type", String)
], SignUpDto.prototype, "name", void 0);
__decorate([
    (0, class_validator_1.IsNotEmpty)(),
    (0, class_validator_1.IsString)(),
    IsUnique({ message: 'Username already taken' }),
    __metadata("design:type", String)
], SignUpDto.prototype, "username", void 0);
__decorate([
    (0, class_validator_1.IsNotEmpty)(),
    (0, class_validator_1.IsEmail)({}, { message: 'Please enter correct email' }),
    __metadata("design:type", String)
], SignUpDto.prototype, "email", void 0);
__decorate([
    (0, class_validator_1.IsNotEmpty)(),
    (0, class_validator_1.MinLength)(6, { message: 'Password must be at least 6 characters long' }),
    __metadata("design:type", String)
], SignUpDto.prototype, "password", void 0);
__decorate([
    (0, class_validator_1.IsNotEmpty)(),
    (0, class_validator_1.IsString)(),
    __metadata("design:type", String)
], SignUpDto.prototype, "role", void 0);
__decorate([
    (0, class_validator_1.ValidateIf)((o) => o.role === 'agency'),
    (0, class_validator_1.IsNotEmpty)({ message: 'Cause is required for agencies' }),
    (0, class_validator_1.IsString)(),
    __metadata("design:type", String)
], SignUpDto.prototype, "cause", void 0);
__decorate([
    (0, class_validator_1.ValidateIf)((o) => o.role === 'agency'),
    (0, class_validator_1.IsNotEmpty)({ message: 'Date is required for agencies' }),
    (0, class_validator_1.IsString)(),
    __metadata("design:type", String)
], SignUpDto.prototype, "date", void 0);
__decorate([
    (0, class_validator_1.ValidateIf)((o) => o.role === 'agency'),
    (0, class_validator_1.IsNotEmpty)({ message: 'Time is required for agencies' }),
    (0, class_validator_1.IsString)(),
    __metadata("design:type", String)
], SignUpDto.prototype, "time", void 0);
__decorate([
    (0, class_validator_1.ValidateIf)((o) => o.role === 'agency'),
    (0, class_validator_1.IsNotEmpty)({ message: 'Service location is required for agencies' }),
    (0, class_validator_1.IsString)(),
    __metadata("design:type", String)
], SignUpDto.prototype, "serviceLocation", void 0);
//# sourceMappingURL=signup.dto.js.map