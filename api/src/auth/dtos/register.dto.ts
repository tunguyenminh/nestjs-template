import { ApiProperty } from '@nestjs/swagger';
import { Gender, UserRole } from '@prisma/client';
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

export class Register {
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
  @IsString()
  @IsNotEmpty()
  readonly phoneCode: string;

  @ApiProperty({
    example: 'password',
  })
  @IsString()
  @IsNotEmpty()
  @NotContains(' ')
  readonly password: string;

  @ApiProperty({
    example: 'Role',
  })
  @IsEnum(UserRole)
  @IsOptional()
  readonly userType: UserRole;

  @ApiProperty({
    example: 'name',
  })
  @IsString()
  @IsNotEmpty()
  readonly fullName: string;
}

export class RegisterCustomer extends Register {
  @ApiProperty({
    example: '0123456789',
  })
  @IsString()
  @IsOptional()
  readonly phone?: string;

  @ApiProperty({
    example: 'email@gmail.com',
  })
  @IsEmail()
  @IsString()
  @IsNotEmpty()
  readonly email: string;

  @ApiProperty({
    example: 'MALE',
  })
  @IsEnum(Gender)
  @IsOptional()
  readonly gender: Gender;
}

export class VerifyOtp {
  @ApiProperty({
    example: '0123456789',
  })
  @IsString()
  @IsOptional()
  readonly phone?: string;

  @ApiProperty({
    example: '0123456789',
  })
  @IsString()
  @IsOptional()
  readonly phoneCode?: string;

  @ApiProperty({
    example: '0123456789',
  })
  @IsEmail()
  @IsOptional()
  readonly email?: string;
}

export class RegisterDTO {
  @ApiProperty({
    example: '0123456789',
  })
  @IsString()
  @IsOptional()
  readonly phone?: string;

  @ApiProperty({
    example: 'phoneCode',
  })
  @IsString()
  @IsOptional()
  readonly phoneCode?: string;

  @ApiProperty({
    example: 'lastName',
  })
  @IsString()
  @IsNotEmpty()
  readonly lastName: string;

  @ApiProperty({
    example: 'firstName',
  })
  @IsString()
  @IsNotEmpty()
  readonly firstName: string;

  @ApiProperty({
    example: 'email@gmail.com',
  })
  @IsString()
  @IsEmail()
  @NotContains(' ')
  @IsNotEmpty()
  readonly email: string;

  @ApiProperty({
    example: 'MALE',
  })
  @IsEnum(Gender)
  @IsOptional()
  readonly gender: Gender;

  @ApiProperty({
    example: 'password',
  })
  @IsString()
  @IsOptional()
  readonly password: string;

  @ApiProperty({
    example: 'confirmPassword',
  })
  @IsString()
  @IsOptional()
  readonly confirmPassword: string;

  @ApiProperty({
    example: 'password',
  })
  @IsBoolean()
  @IsOptional()
  readonly acceptTerm: boolean;
}

export class RegisterVendorDto {
  @ApiProperty({
    example: '0123456789',
  })
  @IsString()
  @IsOptional()
  @NotContains(' ')
  readonly phone: string;

  @ApiProperty({
    example: 'phoneCode',
  })
  @IsString()
  // TODO Change to required
  @IsOptional()
  readonly phoneCode: string;
  @ApiProperty({
    example: 'email@gmail.com',
  })
  @IsString()
  @NotContains(' ')
  @IsEmail()
  @IsOptional()
  readonly email: string;

  @ApiProperty({
    example: 'password',
  })
  @IsString()
  @IsOptional()
  readonly password: string;

  @ApiProperty({
    example: 'confirmPassword',
  })
  @IsString()
  @IsOptional()
  readonly confirmPassword: string;

  @ApiProperty({
    example: true,
  })
  @IsBoolean()
  @IsOptional()
  readonly acceptTerm: boolean;
}

export class RegisterCustomerEmailDto {
  @ApiProperty({
    example: '0123456789',
  })
  @IsEmail()
  @NotContains(' ')
  readonly email: string;

  @ApiProperty({
    example: 'email@gmail.com',
  })
  @IsEmail()
  @IsString()
  @IsOptional()
  readonly password: string;

  @ApiProperty({
    example: 'MALE',
  })
  @IsEnum(Gender)
  @IsOptional()
  readonly confirmPassword: Gender;
}