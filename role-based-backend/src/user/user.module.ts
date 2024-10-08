import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { AuthModule } from 'src/auth/auth.module';
import { MongooseModule } from '@nestjs/mongoose';
import { User, UserSchema } from './schemas/user.schema';
import { IsUniqueConstraint } from './dto/signup.dto';

@Module({
  imports: [
    AuthModule,
    MongooseModule.forFeature([{name:User.name, schema:UserSchema}])
  ],
  providers: [UserService, IsUniqueConstraint],
  controllers: [UserController],
  exports: [UserService]
})
export class UserModule {}
