import { Controller, Get, Post, Body, Patch, Param, Delete, Put, UseGuards, Req, Query, UseInterceptors, UploadedFile } from '@nestjs/common';
import { MulterFile, PostsService } from './posts.service';
import { CreatePostsDto } from './dto/create-posts.dto';
import { UpdatePostsDto } from './dto/update-posts.dto'
import { Posts } from './schemas/posts.schema';
import { AuthGuard } from '@nestjs/passport';
import { FileInterceptor } from '@nestjs/platform-express';


@Controller('posts')
export class PostsController {
  constructor(private readonly postsService: PostsService) { }

  @Post()
  @UseGuards(AuthGuard('agency'))
  async createPosts(@Body() postsDto: CreatePostsDto, @Req() req): Promise<Posts> {
    const createdPost = await this.postsService.createPosts(postsDto);
    return createdPost;
  }

  @Get("myposts/:userId")
  async getMyPosts(@Param('userId') userId: string): Promise<Posts[]> {
    return this.postsService.findMyPosts(userId);
  }

  @Get()
  async getAllPosts(@Query() query: any): Promise<Posts[]> {
    const posts = await this.postsService.findAll(query);
    return posts;
  }

  @Get(':id')
  async getPosts(
    @Param('id')
    id: string
  ): Promise<Posts> {
    return this.postsService.findById(id);
  }

  @Put(':id')
  async updateUser(@Param('id') id: string, @Body() posts: UpdatePostsDto): Promise<Posts> {
    return this.postsService.updatePosts(id, posts)
  }

  @Delete(':id')
  async deletePosts(@Param('id') postsId: string): Promise<void> {
    return this.postsService.deletePosts(postsId);
  }


}
