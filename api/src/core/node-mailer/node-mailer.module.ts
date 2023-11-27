import { Module } from '@nestjs/common';
import { NodeMailerService } from './node-mailer.service';
import { MailerModule } from '@nestjs-modules/mailer';
import { BackendConfigService } from 'src/services/backend-config.service';

@Module({
  providers: [NodeMailerService, BackendConfigService],
  imports: [
    MailerModule.forRootAsync({
      inject: [BackendConfigService],
      useFactory: async (configService: BackendConfigService) => ({
        transport: {
          host: configService.getEnv('MAIL_HOST'),
          port: configService.getEnv('MAIL_PORT'),
          secure: false,
          auth: {
            user: configService.getEnv('MAIL_USERNAME'),
            pass: configService.getEnv('MAIL_PASSWORD'),
          },
        },
        defaults: {
          from: `"GotU" <${configService.getEnv('MAIL_USERNAME')}>`,
        }
      }),
    }),
  ],
  exports: [NodeMailerService],
})
export class NodeMailerModule { }
