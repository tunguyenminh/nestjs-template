import { Module, forwardRef } from '@nestjs/common';
import { CallService } from './call.service';
import { CallController } from './call.controller';
import { Mongoose } from 'mongoose';
import { Call, CallSchema } from './call.schema';
import { MongooseModule } from '@nestjs/mongoose';
import { UserService } from '../user/user.service';
import { UserModule } from '../user/user.module';
import { CallTypeModule } from '../call-type/call-type.module';

@Module({
  controllers: [CallController],
  providers: [CallService],
  exports: [CallService],
  imports: [
    MongooseModule.forFeature([{ name: Call.name, schema: CallSchema }]),
    forwardRef(() => UserModule),
    forwardRef(() => CallTypeModule)
  ]
})
export class CallModule { }
