import { Injectable } from '@nestjs/common';
import * as crypto from 'crypto';
import { MinioClient, MinioService } from 'nestjs-minio-client';
import { Client } from 'minio';
import { BaseException } from 'src/constants/error.constant';
import { BackendConfigService } from 'src/services/backend-config.service';

@Injectable()
export class MinioClientService {
    private readonly BASE_BUCKET;
    private readonly MINIO_ENDPOINT;
    private readonly MINIO_PUBLIC_ENDPOINT;
    private readonly MINIO_PORT;
    private readonly clientConfigs = {};
    constructor(
        private readonly minio: MinioService,
        private readonly configService: BackendConfigService,
    ) {
        this.BASE_BUCKET = configService.getEnv('MINIO_BUCKET');
        this.MINIO_ENDPOINT = configService.getEnv('MINIO_ENDPOINT');
        this.MINIO_PUBLIC_ENDPOINT = configService.getEnv('MINIO_ENDPOINT');
        this.MINIO_PORT = configService.getEnv('MINIO_PORT');
        this.clientConfigs = {
            viewer: {
                endPoint: configService.getEnv('MINIO_PUBLIC_ENDPOINT'),
                port: parseInt(configService.getEnv('MINIO_PORT')),
                useSSL: true,
                accessKey: configService.getEnv('MINIO_ACCESS_KEY'),
                secretKey: configService.getEnv('MINIO_SECRET_KEY'),
            },
            uploader: {
                endPoint: configService.getEnv('MINIO_ENDPOINT'),
                port: parseInt(configService.getEnv('MINIO_PORT')),
                useSSL: false,
                accessKey: configService.getEnv('MINIO_ACCESS_KEY'),
                secretKey: configService.getEnv('MINIO_SECRET_KEY'),
            },
        };
    }

    client(name: string) {
        const client: MinioClient = new Client(this.clientConfigs[name]);
        return client;
    }
}
