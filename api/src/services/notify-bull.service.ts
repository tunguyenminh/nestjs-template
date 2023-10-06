import { Process, Processor } from '@nestjs/bull';
import { Job } from 'bull';
import Redis from 'ioredis';
import { RedisService } from '@liaoliaots/nestjs-redis';
import { CACHE_CONSTANT } from '../constants/cache.constant';
import { COMMON_CONSTANT } from '../constants/common.constant';
import { FirebaseService } from './firebase.service';

@Processor('notify')
export class NotifyBullService {
  private readonly redisInstance: Redis;
  constructor(
    private readonly redisService: RedisService,
    private readonly firebaseService: FirebaseService,
  ) {
    this.redisInstance = this.redisService.getClient(
      COMMON_CONSTANT.REDIS_DEFAULT_NAMESPACE,
    );
  }
  @Process()
  async transcode(job: Job<any>) {
    try {
      // check to push
      const msgData = await this.redisInstance.get(
        CACHE_CONSTANT.NOTIFY_QUEUE_PREFIX,
      );
      if (!msgData) {
        await this.redisInstance.set(CACHE_CONSTANT.NOTIFY_QUEUE_PREFIX, '[]');
      }
      const messages: Array<any> = JSON.parse(msgData) || [];
      if (messages.length >= 500 || job.data?.checkTime === true) {
        // push notify
        await this.redisInstance.set(CACHE_CONSTANT.NOTIFY_QUEUE_PREFIX, '[]');
        await this.firebaseService.firebaseMessaging(messages);
      } else {
        console.log("message length < 500", messages)
        // await this.firebaseService.firebaseMessaging(messages);
        messages.push(job.data);
        await this.redisInstance.set(
          CACHE_CONSTANT.NOTIFY_QUEUE_PREFIX,
          JSON.stringify(messages),
        );
        const checkJobs = (await job.queue.getDelayedCount()) || 0;
        if (checkJobs <= 0) {
          const check = await job.queue.add({ checkTime: true }, { delay: 2 * 1000 });
        }
      }
    } catch (error) {
      console.log('queue error', error);
    }
    return {};
  }
}
