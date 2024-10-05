import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './auth/auth.module';
import { PostsModule } from './posts/posts.module';
import { UserModule } from './user/user.module';
import { CalendarsModule } from './calendars/calendars.module';



@Module({
  imports: [
    //MongooseModule.forRoot("mongodb+srv://ruthalemfanta:TuwCd03wmLP0JkcI@cluster0.lqgxryr.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"),
    MongooseModule.forRoot('mongodb://localhost:27017/sebawi'),
    AuthModule,
    PostsModule,
    UserModule,
    CalendarsModule,

  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule { }
