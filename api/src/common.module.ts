import { ConfigService } from '@nestjs/config';
import { BackendConfigService } from './services/backend-config.service';
import { Global, Module } from '@nestjs/common';
import { FirebaseService } from './services/firebase.service';
import { NotificationTemplateService } from './services/notification-template.service';
import { PrismaModule } from 'prisma/prisma.module';
import { NotifyBullService } from './services/notify-bull.service';

const providers = [BackendConfigService, ConfigService, FirebaseService, NotificationTemplateService, NotifyBullService];

@Global()
@Module({
  providers,
  exports: [...providers],
  imports: [
    PrismaModule

  ],
})
export class CommonModule { }
