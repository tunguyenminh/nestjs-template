import { Injectable, Logger } from '@nestjs/common';
import { InjectQueue } from '@nestjs/bull';
import { Queue } from 'bull';

import { Message } from 'firebase-admin/lib/messaging/messaging-api';
import { NotificationLog, NotificationType, TokenMessaging, Tour, TourGuideStatus, UserRole, UserStatus, VendorStatus } from '@prisma/client';
import { NotificationTemplateService } from '../services/notification-template.service';
import { getSMSTemplate } from 'src/utils/common.utils';

import { BaseException, Errors } from 'src/constants/error.constant';
import moment from 'moment';
import { BackendConfigService } from 'src/services/backend-config.service';

@Injectable()
export class QueueService {
  private logger = new Logger(QueueService.name);
  constructor(
    @InjectQueue('notify') private notifyQueue: Queue,
    @InjectQueue('sms') private smsQueue: Queue,

    private readonly configService: BackendConfigService,
  ) { }

  public async addNotify(
  ) { }
  public async testNotify(deviceId) {
  }
}
