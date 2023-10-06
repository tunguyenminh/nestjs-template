import {
  Controller,
} from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';

import { I18nService } from 'nestjs-i18n';

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

    private readonly i18n: I18nService

  ) { }
}
