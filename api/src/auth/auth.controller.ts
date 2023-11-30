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
import { _excludeObject, checkValidPhoneAndTransform } from 'src/utils/common.utils';

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
    // const phoneNumber = checkValidPhoneAndTransform(body.phoneNumber)
    // const user = await this.userService.findOneIncludePassword({ username: body.username })
    const user = await this.userService.findOneIncludePassword({ $or: [{ username: body.username }, { email: body.username }, { phoneNumber: body.username },] })
    if (!user) throw new BaseException(Errors.BAD_REQUEST("User not found"));
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
    const userExcludePassword = _excludeObject(user, ['password']);

    return { accessToken, user: userExcludePassword }
  }

  @Post("register")
  async register(@Body() body: RegisterDto) {
    const phoneNumber = checkValidPhoneAndTransform(body.phoneNumber)
    const userFound = await this.userService.findOne({
      $or: [
        {
          username: body.username,
        },
        {
          email: body.email
        },
        {
          phoneNumber
        }
      ]
    })
    if (userFound) throw new BaseException(Errors.BAD_REQUEST("Account already existed"));
    const user = await this.userService.create({ username: body.username, email: body.email, phoneNumber, password: await this.authService.hashPassword(body.password), userRole: UserRole.USER })
    let payload: IJwtPayload = { sub: user.id, role: user.userRole };

    let accessToken = await this.authService.generateAccessToken(payload);
    return { accessToken, user }
  }


}
