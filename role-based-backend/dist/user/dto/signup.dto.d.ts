import { ValidationOptions, ValidatorConstraintInterface } from 'class-validator';
import { UserService } from '../user.service';
export declare class IsUniqueConstraint implements ValidatorConstraintInterface {
    private readonly userService;
    constructor(userService: UserService);
    validate(value: string): Promise<boolean>;
    defaultMessage(): string;
}
export declare function IsUnique(validationOptions?: ValidationOptions): (object: Object, propertyName: string) => void;
export declare class SignUpDto {
    readonly name: string;
    readonly username: string;
    readonly email: string;
    readonly password: string;
    readonly role: string;
    readonly cause?: string;
    readonly date?: string;
    readonly time?: string;
    readonly serviceLocation?: string;
}
