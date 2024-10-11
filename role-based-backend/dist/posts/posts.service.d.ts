/// <reference types="node" />
/// <reference types="mongoose/types/aggregate" />
/// <reference types="mongoose/types/callback" />
/// <reference types="mongoose/types/collection" />
/// <reference types="mongoose/types/connection" />
/// <reference types="mongoose/types/cursor" />
/// <reference types="mongoose/types/document" />
/// <reference types="mongoose/types/error" />
/// <reference types="mongoose/types/expressions" />
/// <reference types="mongoose/types/helpers" />
/// <reference types="mongoose/types/middlewares" />
/// <reference types="mongoose/types/indexes" />
/// <reference types="mongoose/types/models" />
/// <reference types="mongoose/types/mongooseoptions" />
/// <reference types="mongoose/types/pipelinestage" />
/// <reference types="mongoose/types/populate" />
/// <reference types="mongoose/types/query" />
/// <reference types="mongoose/types/schemaoptions" />
/// <reference types="mongoose/types/schematypes" />
/// <reference types="mongoose/types/session" />
/// <reference types="mongoose/types/types" />
/// <reference types="mongoose/types/utility" />
/// <reference types="mongoose/types/validation" />
/// <reference types="mongoose/types/virtuals" />
/// <reference types="mongoose/types/inferschematype" />
/// <reference types="mongoose/types/inferrawdoctype" />
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
        __v?: number;
    })[]>;
    findAll(query: any): Promise<Posts[]>;
    findMyPosts(userId: string): Promise<Posts[]>;
    findById(id: string): Promise<Posts>;
    updatePosts(id: string, posts: Posts): Promise<Posts>;
    deletePosts(postsId: string): Promise<void>;
}
