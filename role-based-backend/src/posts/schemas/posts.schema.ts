import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose from "mongoose";
import { User } from '../../user/schemas/user.schema';

@Schema({
    timestamps: true
})

export class Posts {
    @Prop({ required: true })
    name: string;

    @Prop({ required: true })
    description: string;

    @Prop({ required: true })
    contact: string;

    @Prop({ required: true })
    user: string;


}

export const PostsSchema = SchemaFactory.createForClass(Posts)