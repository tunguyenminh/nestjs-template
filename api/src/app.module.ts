import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { APP_FILTER, APP_INTERCEPTOR } from '@nestjs/core';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AllExceptionsFilter } from './helpers/http-exception.filter';
import { LoggerMiddleware } from './helpers/logger.middleware';
import { TransformInterceptor } from './helpers/transform.interceptor';
import { AuthModule } from './auth/auth.module';
import { CoreModule } from './core/core.module';
import { IPMiddleware } from './helpers/ip.middleware';
import { BullModule } from '@nestjs/bull';
import { BackendConfigService } from './services/backend-config.service';
import { I18nModule, AcceptLanguageResolver, QueryResolver, HeaderResolver, I18nMiddleware } from 'nestjs-i18n';

import path from 'path';
import { I18nCustomModule } from './i18n/i18n.module';
import { CommonModule } from './common.module';
import { DatabaseModule } from './core/database/database.module';
import { UserModule } from './models/user/user.module';
import { CallModule } from './models/call/call.module';
import { CallTypeModule } from './models/call-type/call-type.module';
import { WebhookModule } from './webhook/webhook.module';

@Module({
  imports: [
    AuthModule,
    CoreModule,
    I18nCustomModule,
    CommonModule,
    DatabaseModule,
    UserModule,
    CallModule,
    CallTypeModule,
    WebhookModule,
    I18nModule.forRootAsync({
      useFactory: (configService: BackendConfigService) => ({
        fallbackLanguage: configService.getEnv("FALLBACK_LANGUAGE"),
        loaderOptions: {
          path: path.join(__dirname, '../resources/locales'),
          watch: true,
        },
      }),
      resolvers: [
        { use: HeaderResolver, options: ['x-lang'] },
        AcceptLanguageResolver
      ],
      inject: [BackendConfigService],
    }),
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_FILTER,
      useClass: AllExceptionsFilter,
    },
    {
      provide: APP_INTERCEPTOR,
      useClass: TransformInterceptor,
    },
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer): void {
    consumer.apply(IPMiddleware).forRoutes('*');
    consumer.apply(LoggerMiddleware).forRoutes('*');
  }
}
