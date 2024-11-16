import { Posts } from './schemas/posts.schema';
import mongoose, { Model } from 'mongoose';
import { CreatePostsDto } from './dto/create-posts.dto';
export interface MulterFile {
    fieldname: string;
    originalname: string;
    encoding: string;
    mimetype: string;
    size: number;
    destination: string;
    filename: string;
    path: string;
    buffer: Buffer;
}
export declare class PostsService {
    private readonly postsModel;
    constructor(postsModel: Model<Posts>);
    createPosts(createPostsDto: CreatePostsDto): Promise<Posts>;
    readPosts(): Promise<void | (mongoose.Document<unknown, {}, Posts> & Posts & {
        _id: mongoose.Types.ObjectId;
    } & {
        __v: number;
    })[]>;
    findAll(query: any): Promise<Posts[]>;
    findMyPosts(userId: string): Promise<Posts[]>;
    findById(id: string): Promise<Posts>;
    updatePosts(id: string, posts: Posts): Promise<Posts>;
    deletePosts(postsId: string): Promise<void>;
}
