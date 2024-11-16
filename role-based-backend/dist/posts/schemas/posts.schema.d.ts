import mongoose from "mongoose";
export declare class Posts {
    name: string;
    description: string;
    contact: string;
    user: string;
}
export declare const PostsSchema: mongoose.Schema<Posts, mongoose.Model<Posts, any, any, any, mongoose.Document<unknown, any, Posts> & Posts & {
    _id: mongoose.Types.ObjectId;
} & {
    __v: number;
}, any>, {}, {}, {}, {}, mongoose.DefaultSchemaOptions, Posts, mongoose.Document<unknown, {}, mongoose.FlatRecord<Posts>> & mongoose.FlatRecord<Posts> & {
    _id: mongoose.Types.ObjectId;
} & {
    __v: number;
}>;
