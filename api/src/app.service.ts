import { Injectable } from '@nestjs/common';

import { UserService } from './models/user/user.service';
import { Gender, UserRole } from './constants/enum.constant';
import { compare, hash } from 'bcryptjs';
import { BackendConfigService } from './services/backend-config.service';
import { CallTypeService } from './models/call-type/call-type.service';
import { CallTypeStatus } from './models/call-type/call-type.enum';

@Injectable()
export class AppService {
  constructor(
    private readonly userService: UserService,
    private readonly callTypeService: CallTypeService,
    private readonly configService: BackendConfigService
  ) { }

  async onApplicationBootstrap() {
    // console.log("onApplicationBootstrap")
    // const callType = await this.callTypeService.findOne({})
    // if (!callType) {
    //   await this.callTypeService.createMany([{
    //     title: "OK",
    //     status: CallTypeStatus.ACTIVE,
    //     price: 1000
    //   }])
    // }
    // const admin = await this.userService.findOne({})
    // console.log(admin)
    // if (!admin) {
    //   await this.userService.createMany(
    //     [
    //       {
    //         username: "Admin01",
    //         userRole: UserRole.ADMIN,
    //         email: "admin01@gmail.com",
    //         password: await hash(
    //           "Admin@123",
    //           parseInt(this.configService.getEnv('AUTH_SALT_ROUND')),
    //         )
    //       },
    //       {
    //         username: "Admin02",
    //         userRole: UserRole.ADMIN,
    //         email: "admin02@gmail.com",
    //         password: await hash(
    //           "Admin@123",
    //           parseInt(this.configService.getEnv('AUTH_SALT_ROUND')),
    //         )
    //       },
    //       {
    //         username: "Admin03",
    //         userRole: UserRole.ADMIN,
    //         email: "admin03@gmail.com",
    //         password: await hash(
    //           "Admin@123",
    //           parseInt(this.configService.getEnv('AUTH_SALT_ROUND')),
    //         )
    //       },
    //       {
    //         username: "Admin04",
    //         userRole: UserRole.ADMIN,
    //         email: "admin04@gmail.com",
    //         password: await hash(
    //           "Admin@123",
    //           parseInt(this.configService.getEnv('AUTH_SALT_ROUND')),
    //         )
    //       }
    //     ])
    // }
  }
}
