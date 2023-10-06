import { Module, forwardRef } from '@nestjs/common';

import { CronTasksService } from './cron-tasks.service';

@Module({
  imports: [],
  providers: [CronTasksService],
  exports: [CronTasksService],
})
export class CronTasksModule {}
