import { PostsService } from './posts.service';
import { CreatePostsDto } from './dto/create-posts.dto';
import { UpdatePostsDto } from './dto/update-posts.dto';
import { Posts } from './schemas/posts.schema';
export declare class PostsController {
    private readonly postsService;
    constructor(postsService: PostsService);
    createPosts(postsDto: CreatePostsDto, req: any): Promise<Posts>;
    getMyPosts(userId: string): Promise<Posts[]>;
    getAllPosts(query: any): Promise<Posts[]>;
    getPosts(id: string): Promise<Posts>;
    updateUser(id: string, posts: UpdatePostsDto): Promise<Posts>;
    deletePosts(postsId: string): Promise<void>;
}
