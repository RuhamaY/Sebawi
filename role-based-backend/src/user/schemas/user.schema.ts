import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export enum UserRole {
  Admin = 'admin',
  User = 'user',
  Agency = 'agency'
}

@Schema({
  timestamps: true,
})
export class User extends Document {
  @Prop({ required: true })
  name: string;

  @Prop({ unique: true, required: true })
  username: string;

  @Prop({ unique: true, required: true})
  email: string;

  @Prop()
  password: string;

  @Prop()
  role: UserRole;

  // Additional fields for Agency users only
  @Prop({
    required: function () {
      return this.role === UserRole.Agency;
    },
  })
  cause?: string;

  @Prop({
    required: function () {
      return this.role === UserRole.Agency;
    },
  })
  date?: string;

  @Prop({
    required: function () {
      return this.role === UserRole.Agency;
    },
  })
  time?: string;

  @Prop({
    required: function () {
      return this.role === UserRole.Agency;
    },
  })
  serviceLocation?: string;

  static _id: any;  // Mongoose provides the _id property automatically
}

export const UserSchema = SchemaFactory.createForClass(User);