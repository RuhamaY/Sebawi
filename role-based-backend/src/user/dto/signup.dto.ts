import { IsEmail, IsNotEmpty, IsString, registerDecorator, ValidationOptions, ValidatorConstraint, ValidatorConstraintInterface, MinLength, IsStrongPassword, ValidateIf } from 'class-validator';
import { UserService } from 'src/user/user.service';
import { Injectable } from '@nestjs/common';

@Injectable()
@ValidatorConstraint({ async: true })
export class IsUniqueConstraint implements ValidatorConstraintInterface {
  constructor(private readonly userService: UserService) { }

  async validate(value: any): Promise<boolean> {
    const user = await this.userService.findByUsername(value);
    // return !user;
    return user === null || user === undefined;
  }

  defaultMessage(): string {
    return 'Username is already taken';
  }
}

export function IsUnique(validationOptions?: ValidationOptions) {
  return function (object: Object, propertyName: string): void {
    registerDecorator({
      name: 'isUnique',
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      validator: IsUniqueConstraint,
    });
  };
}


export class SignUpDto {

  @IsNotEmpty()
  @IsString()
  readonly name: string;

  @IsNotEmpty()
  @IsString()
  @IsUnique({ message: 'Username already taken' })
  readonly username: string;

  @IsNotEmpty()
  @IsEmail({}, { message: 'Please enter correct email' })
  readonly email: string;

  @IsNotEmpty()
  @MinLength(6, { message: 'Password must be at least 6 characters long'})
  readonly password: string;

  @IsNotEmpty()
  @IsString()
  readonly role: string;

  // Agency-specific fields
  @ValidateIf((o) => o.role === 'agency')
  @IsNotEmpty({ message: 'Cause is required for agencies' })
  @IsString()
  readonly cause?: string;

  @ValidateIf((o) => o.role === 'agency')
  @IsNotEmpty({ message: 'Date is required for agencies' })
  @IsString()
  readonly date?: string;

  @ValidateIf((o) => o.role === 'agency')
  @IsNotEmpty({ message: 'Time is required for agencies' })
  @IsString()
  readonly time?: string;

  @ValidateIf((o) => o.role === 'agency')
  @IsNotEmpty({ message: 'Service location is required for agencies' })
  @IsString()
  readonly serviceLocation?: string;
}