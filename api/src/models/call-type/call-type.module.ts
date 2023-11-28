import { Module, forwardRef } from '@nestjs/common';
import { CallTypeService } from './call-type.service';
import { CallTypeController } from './call-type.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Call, CallSchema } from '../call/call.schema';
import { UserModule } from '../user/user.module';
import { CallModule } from '../call/call.module';
import { CallType, CallTypeSchema } from './call-type.schema';

@Module({
  controllers: [CallTypeController],
  providers: [CallTypeService],
  imports: [
    MongooseModule.forFeature([{ name: CallType.name, schema: CallTypeSchema }]),
    forwardRef(() => UserModule),
    forwardRef(() => CallModule)
  ],
  exports: [CallTypeService]
})
export class CallTypeModule { }
