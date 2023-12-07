import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { BackendConfigService } from 'src/services/backend-config.service';

const dbConfig = MongooseModule.forRootAsync({
  imports: [ConfigModule],
  inject: [BackendConfigService],
  useFactory: async (configService: BackendConfigService) => {
    return {
      uri: configService.getEnv('MONGODB_URI'),
    };
  },
});

@Module({
  imports: [dbConfig],
  exports: [dbConfig],
})

export class DatabaseModule { }
