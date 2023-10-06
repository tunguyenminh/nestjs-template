import { ApiProperty } from '@nestjs/swagger';
import { Gender, UserRole } from '@prisma/client';
import { ResetPasswordMethod } from 'src/constants/enum.constant';
import {
  IsEmail,
  IsEnum,
  IsNotEmpty,
  IsOptional,
  IsString,
  NotContains,
} from 'class-validator';

export class ForgotPassword {
  @ApiProperty({
    required: true
  })
  @IsString()
  @IsOptional()
  @NotContains(' ')
  readonly phone?: string;

  @ApiProperty({
    required: true
  })
  @IsEmail()
  @IsOptional()
  @NotContains(' ')
  readonly email?: string;

  @ApiProperty({
    required: true
  })
  @IsString()
  @IsOptional()
  @NotContains(' ')
  readonly phoneCode?: string;

  @ApiProperty({
    required: true
  })
  @IsEnum(UserRole)
  @IsNotEmpty()
  readonly role: UserRole

  @ApiProperty({
    required: true
  })
  @IsEnum(ResetPasswordMethod)
  @IsNotEmpty()
  readonly method: ResetPasswordMethod;
}

export class ChangePassword {
  @ApiProperty({
    required: true
  })
  @IsEnum(UserRole)
  @IsNotEmpty()
  readonly role: UserRole;

  @ApiProperty({
    required: true
  })
  @IsString()
  @IsNotEmpty()
  @NotContains(' ')
  readonly password: string;

  @ApiProperty({
    required: true
  })
  @IsString()
  @IsNotEmpty()
  @NotContains(' ')
  readonly confirmPassword: string;


  @ApiProperty({
    required: true
  })
  @IsString()
  @IsNotEmpty()
  @NotContains(' ')
  readonly phone: string;

  @ApiProperty({
    required: true
  })
  @IsString()
  @IsNotEmpty()
  @NotContains(' ')
  readonly phoneCode: string;
}

export class ChangePasswordEmailDto {
  @ApiProperty({
    required: true
  })
  @IsEnum(UserRole)
  @IsNotEmpty()
  readonly role: UserRole;

  @ApiProperty({
    required: true
  })
  @IsString()
  @IsNotEmpty()
  @NotContains(' ')
  readonly password: string;

  @ApiProperty({
    required: true
  })
  @IsString()
  @IsNotEmpty()
  @NotContains(' ')
  readonly confirmPassword: string;

  @ApiProperty({
    required: true
  })
  @IsEmail()
  @IsNotEmpty()
  readonly email: string;
}

export class VerifyEmailOtpDto {
  @ApiProperty({
    required: true
  })
  @IsEnum(UserRole)
  @IsNotEmpty()
  readonly role: UserRole;

  @ApiProperty({
    required: true
  })
  @IsEmail()
  @IsNotEmpty()
  readonly email: string;

}

export class VerifyOtpDto {
  @ApiProperty({
    required: true
  })
  @IsEnum(UserRole)
  @IsNotEmpty()
  readonly role: UserRole;

  @ApiProperty({
    required: true
  })
  @IsString()
  @IsNotEmpty()
  @NotContains(' ')
  readonly phone: string;

  @ApiProperty({
    required: true
  })
  @IsString()
  @IsNotEmpty()
  @NotContains(' ')
  readonly phoneCode: string
}