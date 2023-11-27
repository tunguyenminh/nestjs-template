import { ApiProperty } from '@nestjs/swagger';
import {
  IsBoolean,
  IsEmail,
  IsEnum,
  IsNotEmpty,
  IsOptional,
  IsPhoneNumber,
  IsString,
  Matches,
  NotContains,
} from 'class-validator';
import { Gender, UserRole } from 'src/constants/enum.constant';

export class RegisterDto {
  @ApiProperty({
    example: 'username',
  })
  @IsString()
  @IsNotEmpty()
  @NotContains(' ')
  readonly username: string;

  @ApiProperty({
    example: 'username',
  })
  @IsEmail()
  @IsNotEmpty()
  @NotContains(' ')
  readonly email: string;

  @ApiProperty({
    example: 'username',
  })
  @IsString()
  @IsNotEmpty()
  readonly phoneNumber: string;

  @ApiProperty({
    example: 'password',
  })
  @IsString()
  @IsNotEmpty()
  @NotContains(' ')
  readonly password: string;

  @ApiProperty({
    example: 'password',
  })
  @IsString()
  @IsNotEmpty()
  @NotContains(' ')
  readonly confirmPassword: string;

  @ApiProperty({
    example: 'password',
  })
  @IsEnum(Gender)
  @IsOptional()
  readonly gender?: Gender;
}