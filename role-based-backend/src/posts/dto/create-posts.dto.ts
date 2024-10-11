import { IsEmpty, IsNotEmpty, IsString } from "class-validator";
import { User } from "src/user/schemas/user.schema";
import { File } from 'multer';

export class CreatePostsDto {

    @IsNotEmpty()
    @IsString()
    readonly name: string;

    @IsNotEmpty()
    @IsString()
    readonly description: string;

    @IsNotEmpty()
    @IsString()
    readonly contact: string;

    @IsNotEmpty()
    @IsString()
    readonly user: string;
}
