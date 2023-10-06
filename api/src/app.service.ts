import { Injectable } from '@nestjs/common';
import { PrismaService } from 'prisma/prisma.service';

import { CONFIGURATION_CODE_CONSTANT } from './constants/common.constant';

@Injectable()
export class AppService {
  constructor(
    private readonly prisma: PrismaService,
  ) { }

  async getHello() {
    return this.prisma.user.findFirstOrThrow({ where: { id: 1 } });
  }

  async onApplicationBootstrap() {

  }
}
