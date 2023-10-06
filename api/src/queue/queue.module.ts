import { Module, forwardRef } from '@nestjs/common';
import { QueueService } from './queue.service';
import { BullModule } from '@nestjs/bull';
@Module({
  providers: [QueueService],
  imports: [
    BullModule.registerQueue({
      name: 'notify',
    }),
    BullModule.registerQueue({
      name: 'sms',
    }),
  ],
  exports: [QueueService],
})
export class QueueModule { }
