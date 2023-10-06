import { Module, forwardRef } from '@nestjs/common';
import { PassportModule } from '@nestjs/passport';
import { JwtModule } from '@nestjs/jwt';

import { JwtStrategy } from './strategies/jwt.strategy';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import configurationCommon from 'src/common/configuration.common';
import { JwtAuthGuard } from './guards/jwt-auth.guard';
import { RolesGuard } from './guards/roles.guard';
import { PrismaModule } from '../../prisma/prisma.module';

@Module({
  imports: [
    PassportModule,
    JwtModule.register({
      secret: configurationCommon().jwt.secret,
      signOptions: { expiresIn: '30d' },
    }),
    PrismaModule,

  ],
  controllers: [AuthController],
  providers: [AuthService, RolesGuard, JwtAuthGuard, JwtStrategy],
  exports: [AuthService],
})
export class AuthModule { }
