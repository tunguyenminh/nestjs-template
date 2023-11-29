import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { _excludeObject, excludeObject } from 'src/utils/common.utils';
import { BackendConfigService } from '../../services/backend-config.service';
import { IJwtPayload } from '../interfaces/jwt-payload.interface';
import { BaseException, Errors } from 'src/constants/error.constant';
import { UserRole, UserStatus } from 'src/constants/enum.constant';
import { UserService } from 'src/models/user/user.service';
import mongoose from 'mongoose';


// type UserWithoutPassword = Omit<User, 'password'>;
// interface IUser extends UserWithoutPassword {
//   Customer?: Customer[];
//   TourGuides?: TourGuide[];
//   Vendor?: Vendor[];
// }
export interface IUserJwt {
  data: any;
  role: UserRole;
}
@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(
    private readonly userService: UserService,

    private readonly configService: BackendConfigService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: configService.getEnv('AUTH_JWT_ACCESS_SECRET'),
      passReqToCallback: true,
    });
  }

  async validate(req: Request, payload: IJwtPayload): Promise<IUserJwt> {
    let user: any;
    // const accessToken = req.headers['authorization'].replace('Bearer ', '');

    // if (accessToken !== user?.lastAccessToken) {
    //   throw new HttpException('Invalid Access Token', HttpStatus.UNAUTHORIZED);
    // }

    user = await this.userService.findOne({ _id: new mongoose.Types.ObjectId(payload.sub) })
    if (!user) throw new BaseException(Errors.ITEM_NOT_FOUND('Account'));

    if (user.userStatus === UserStatus.BANNED) {
      throw new HttpException('User has been locked', HttpStatus.UNAUTHORIZED);
    }

    const userExcludePassword = _excludeObject(user, ['password']);
    return { data: userExcludePassword, role: user.userRole };
  }
}
