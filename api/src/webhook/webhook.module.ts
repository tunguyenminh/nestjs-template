import { forwardRef, Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { WebhookController } from './webhook.controller';
import { CallModule } from 'src/models/call/call.module';


@Module({
  imports: [
    forwardRef(() => CallModule)
  ],
  controllers: [WebhookController],
  providers: [],
  exports: [],
})
export class WebhookModule { }
