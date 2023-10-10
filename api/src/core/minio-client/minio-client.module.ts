import { Module, forwardRef } from '@nestjs/common';
import { MinioClientService } from './minio-client.service';
import { MinioModule, MinioService } from 'nestjs-minio-client';
import { BackendConfigService } from 'src/services/backend-config.service';

@Module({
  providers: [MinioClientService],
  imports: [
    MinioModule.registerAsync({
      inject: [BackendConfigService],
      useFactory: (config: BackendConfigService) => {
        return {
          endPoint: config.getEnv('MINIO_ENDPOINT'),
          port: parseInt(config.getEnv('MINIO_PORT')),
          useSSL: false,
          accessKey: config.getEnv('MINIO_ACCESS_KEY'),
          secretKey: config.getEnv('MINIO_SECRET_KEY'),
        };
      },
    }),
  ],
  exports: [MinioClientService],
})
export class MinioClientModule { }

