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
exports.CalendarsController = void 0;
const common_1 = require("@nestjs/common");
const calendars_service_1 = require("./calendars.service");
const create_calendar_dto_1 = require("./dto/create-calendar.dto");
const update_calendar_dto_1 = require("./dto/update-calendar.dto");
const passport_1 = require("@nestjs/passport");
let CalendarsController = class CalendarsController {
    constructor(calendarsService) {
        this.calendarsService = calendarsService;
    }
    async createEvent(postId, createEventDto, req) {
        const user = req.user;
        const createdEvent = await this.calendarsService.createEvent(createEventDto, postId, user);
        createdEvent.user = user._id;
        return createdEvent;
    }
    async findAllByUser(req) {
        const userId = req.user.id;
        return this.calendarsService.findAllByUser(userId);
    }
    findOne(id) {
        return this.calendarsService.findOne(+id);
    }
    findAllByPost(postId) {
        return this.calendarsService.findAllByPost(postId);
    }
    update(id, updateCalendarDto) {
        return this.calendarsService.update(+id, updateCalendarDto);
    }
    remove(id) {
        return this.calendarsService.remove(+id);
    }
};
exports.CalendarsController = CalendarsController;
__decorate([
    (0, common_1.Post)('add/:postId'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)()),
    __param(0, (0, common_1.Param)('postId')),
    __param(1, (0, common_1.Body)()),
    __param(2, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, create_calendar_dto_1.CreateCalendarDto, Object]),
    __metadata("design:returntype", Promise)
], CalendarsController.prototype, "createEvent", null);
__decorate([
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)()),
    (0, common_1.Get)('mycalendar'),
    __param(0, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], CalendarsController.prototype, "findAllByUser", null);
__decorate([
    (0, common_1.Get)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], CalendarsController.prototype, "findOne", null);
__decorate([
    (0, common_1.Get)('post/:postId'),
    __param(0, (0, common_1.Param)('postId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], CalendarsController.prototype, "findAllByPost", null);
__decorate([
    (0, common_1.Patch)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_calendar_dto_1.UpdateCalendarDto]),
    __metadata("design:returntype", void 0)
], CalendarsController.prototype, "update", null);
__decorate([
    (0, common_1.Delete)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], CalendarsController.prototype, "remove", null);
exports.CalendarsController = CalendarsController = __decorate([
    (0, common_1.Controller)('calendars'),
    __metadata("design:paramtypes", [calendars_service_1.CalendarsService])
], CalendarsController);
//# sourceMappingURL=calendars.controller.js.map