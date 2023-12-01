import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsEnum, IsNotEmpty, IsOptional, IsString, NotContains } from 'class-validator';
import { LoginMethod, SocialConnectionType, UserRole } from 'src/constants/enum.constant';
import { OtpAction } from 'src/constants/otp-action.constant';
export class LoginDto {
  @ApiProperty({
    example: 'Admin01',
    required: true
  })
  @IsString()
  @IsNotEmpty()
  readonly username: string;

  @ApiProperty({
    example: 'Admin@123',
    required: true
  })
  @IsString()
  @IsNotEmpty()
  readonly password: string;
}

