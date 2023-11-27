import { Platform, UserRole } from 'src/constants/enum.constant';

export class IJwtPayload {
  sub: number;

  iat?: number;

  exp?: number;

  role?: UserRole;

  platform?: Platform;
}
