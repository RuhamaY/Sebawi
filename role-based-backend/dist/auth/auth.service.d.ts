import { Model } from 'mongoose';
import { User } from '../user/schemas/user.schema';
import { JwtService } from '@nestjs/jwt';
import { SignUpDto } from '../user/dto/signup.dto';
import { LogInDto } from '../user/dto/login.dto';
export declare class AuthService {
    private userModel;
    private jwtService;
    constructor(userModel: Model<User>, jwtService: JwtService);
    signUp(signUpDto: SignUpDto): Promise<{
        token: string;
    }>;
    login(loginDto: LogInDto): Promise<{
        userId: string;
        token: string;
        status: string;
    }>;
}
