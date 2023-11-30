import { forwardRef, Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { WebhookController } from './webhook.controller';


@Module({
  imports: [
  ],
  controllers: [WebhookController],
  providers: [],
  exports: [],
})
export class WebhookModule { }
