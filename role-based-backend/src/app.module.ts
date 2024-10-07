import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './auth/auth.module';
import { PostsModule } from './posts/posts.module';
import { UserModule } from './user/user.module';
import { CalendarsModule } from './calendars/calendars.module';

// mongodb+srv://ruthalemfanta:TuwCd03wmLP0JkcI@cluster0.lqgxryr.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0
// mongodb+srv://tayejoshua4:Qm*X!AR2XGJtUvd@sebawi-app.3xgf2rf.mongodb.net/?retryWrites=true&w=majority&appName=Sebawi-app
@Module({
  imports: [
    MongooseModule.forRoot("mongodb+srv://tayejoshua4:Qm*X!AR2XGJtUvd@sebawi-app.3xgf2rf.mongodb.net/?retryWrites=true&w=majority&appName=Sebawi-app"),
    AuthModule,
    PostsModule,
    UserModule,
    CalendarsModule,

  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule { }
