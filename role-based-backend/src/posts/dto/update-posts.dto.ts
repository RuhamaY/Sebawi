
import { PartialType } from '@nestjs/mapped-types';
import { IsEmpty, IsNotEmpty, IsOptional, IsString } from 'class-validator';
import { User } from 'src/user/schemas/user.schema';
import { CreatePostsDto } from './create-posts.dto';

export class UpdatePostsDto {

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    readonly name: string;

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    readonly description: string;

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    readonly contact: string;

    @IsEmpty({ message: 'you can not pass user id' })
    readonly user: string;
}
