import { Controller, Get, Post, Body, Patch, Param, Delete, Req, UseGuards } from '@nestjs/common';
import { CalendarsService } from './calendars.service';
import { CreateCalendarDto } from './dto/create-calendar.dto';
import { UpdateCalendarDto } from './dto/update-calendar.dto';
import { Calendars } from './schema/calendar.schema';
import { AuthGuard } from '@nestjs/passport';

@Controller('calendars')
export class CalendarsController {
  constructor(private readonly calendarsService: CalendarsService) { }

  @Post('add/:postId')
  @UseGuards(AuthGuard())
  async createEvent(@Param('postId') postId: string, @Body() createEventDto: CreateCalendarDto, @Req() req): Promise<Calendars> {
    const user = req.user;

    const createdEvent = await this.calendarsService.createEvent(createEventDto, postId, user);
    createdEvent.user = user._id;

    return createdEvent;
  }

  @UseGuards(AuthGuard())
  @Get('mycalendar')
  async findAllByUser(@Req() req) {
    const userId = req.user.id;
    return this.calendarsService.findAllByUser(userId);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.calendarsService.findOne(+id);
  }

  @Get('post/:postId')
  findAllByPost(@Param('postId') postId: string) {
    return this.calendarsService.findAllByPost(postId);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateCalendarDto: UpdateCalendarDto) {
    return this.calendarsService.update(+id, updateCalendarDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.calendarsService.remove(+id);
  }
}
