import { Injectable } from '@nestjs/common';
import { CreateCalendarDto } from './dto/create-calendar.dto';
import { UpdateCalendarDto } from './dto/update-calendar.dto';
import { Model } from 'mongoose';
import { InjectModel } from '@nestjs/mongoose';
import { Calendars } from './schema/calendar.schema';
import { User } from 'src/user/schemas/user.schema';

@Injectable()
export class CalendarsService {
  constructor(
    @InjectModel('calendars') private readonly calendarsModel: Model<Calendars>,
  ) { }

  async createEvent(createEventDto: CreateCalendarDto, postId: string, user: User): Promise<Calendars> {
    const createdEvent = new this.calendarsModel({
      ...createEventDto,
      post: postId,
      user: user,
    });
    return createdEvent.save();
  }

  async findAllByUser(userId: string): Promise<Calendars[]> {
    return this.calendarsModel.find({ user: userId }).exec();
  }

  async findAllByPost(postId: string) {
    return this.calendarsModel.find({ post: postId }).exec();
  }

  findOne(id: number) {
    return `This action returns a #${id} calendar`;
  }

  update(id: number, updateCalendarDto: UpdateCalendarDto) {
    return `This action updates a #${id} calendar`;
  }

  remove(id: number) {
    return `This action removes a #${id} calendar`;
  }
}
