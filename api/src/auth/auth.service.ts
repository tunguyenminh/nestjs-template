import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { compare, hash } from 'bcryptjs';
import axios from 'axios';

import { IJwtPayload } from './interfaces/jwt-payload.interface';
import { BackendConfigService } from '../services/backend-config.service';

import { UserRole } from 'src/constants/enum.constant';

@Injectable()
export class AuthService {
  constructor(
    private readonly jwtService: JwtService,
    private readonly configService: BackendConfigService,

  ) { }

  async hashPassword(password: string) {
    return await hash(
      password,
      parseInt(this.configService.getEnv('AUTH_SALT_ROUND')),
    );
  }

  async comparePassword(inputPassword: string, hashPassword: string) {
    return await compare(inputPassword, hashPassword);
  }


  async generateAccessToken(payload: IJwtPayload): Promise<string> {
    if (payload.role === UserRole.USER) {
      return await this.jwtService.signAsync(payload, {
        secret: this.configService.getEnv('AUTH_JWT_ACCESS_SECRET'),
      });
    }
    return await this.jwtService.signAsync(payload, {
      expiresIn: this.configService.getEnv('AUTH_ADMIN_JWT_ACCESS_EXPIRES_IN'),
      secret: this.configService.getEnv('AUTH_JWT_ACCESS_SECRET'),
    });
  }
  async generateRefreshToken(
    payload: IJwtPayload,
    isRemember?: boolean,
  ): Promise<string> {
    return await this.jwtService.signAsync(payload, {
      expiresIn: isRemember
        ? this.configService.getEnv(
          'AUTH_ADMIN_JWT_REFRESH_REMEMBER_EXPIRES_IN',
        )
        : this.configService.getEnv('AUTH_ADMIN_JWT_REFRESH_EXPIRES_IN'),
      secret: this.configService.getEnv('AUTH_JWT_REFRESH_SECRET'),
    });
  }
}
