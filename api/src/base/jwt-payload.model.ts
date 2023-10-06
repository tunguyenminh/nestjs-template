import { Platform } from '../constants/enum.constant';

export class JwtPayloadModel {
  sub: number;

  iat?: number;

  exp?: number;

  role: string;

  platform?: Platform;
}
