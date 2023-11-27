import {
  Body,
  Controller, Post,
} from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';

import { I18nService } from 'nestjs-i18n';
import { LoginDto } from './dtos/auth-login.dto';
import { UserService } from 'src/models/user/user.service';
import { AuthService } from './auth.service';
import { BaseException, Errors } from 'src/constants/error.constant';
import { IJwtPayload } from './interfaces/jwt-payload.interface';
import { UserRole } from 'src/constants/enum.constant';
import { RegisterDto } from './dtos/register.dto';

export interface LoginData {
  phone?: string;
  phoneCode?: string;
  email?: string;
  password: string;
}
@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(
    private readonly userService: UserService,
    private readonly authService: AuthService,

    private readonly i18n: I18nService

  ) { }
  @Post("login")
  async loginIn(@Body() body: LoginDto) {
    // const user = await this.userService.findOneIncludePassword({ username: body.username })
    const user = await this.userService.findOneIncludePassword({ $or: [{ username: body.username }, { email: body.username }] })
    if (
      !(await this.authService.comparePassword(
        body.password,
        user.password,
      ))
    ) {
      throw new BaseException(Errors.WRONG_PASSWORD());
    }

    let payload: IJwtPayload = { sub: user.id, role: user.userRole };
    let accessToken = await this.authService.generateAccessToken(payload);

    return { accessToken }
  }

  @Post("register")
  async register(@Body() body: RegisterDto) {
    const user = await this.userService.findOne({
      $or: [
        {
          username: body.username,
        },
        {
          email: body.email
        },
        {
          phoneNumber: body.phoneNumber
        }
      ]
    })
    if (user) throw new BaseException(Errors.BAD_REQUEST("Account already existed"));
    await this.userService.create({ username: body.username, email: body.email, phoneNumber: body.phoneNumber, password: await this.authService.hashPassword(body.password), userRole: UserRole.USER })
    let payload: IJwtPayload = { sub: user.id, role: user.userRole };

    let accessToken = await this.authService.generateAccessToken(payload);
    return { accessToken }
  }


}
