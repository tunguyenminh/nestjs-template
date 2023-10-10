import { Injectable } from '@nestjs/common';
import * as crypto from 'crypto';
import { MinioClient, MinioService } from 'nestjs-minio-client';
import { BackendConfigService } from 'src/services/backend-config.service';
// import { Errors } from '../constants/error.constant';
// import { getBufferAndFileNameFromFileUploadGraphQL } from '../utils/common.util';
import { Client } from 'minio';
import { BaseException, Errors } from 'src/constants/error.constant';
import { getBufferAndFileNameFromFileUploadMulter } from 'src/utils/common.utils';

@Injectable()
export class MinioClientService {
  private readonly BASE_BUCKET;
  private readonly MINIO_ENDPOINT;
  private readonly MINIO_PORT;
  private readonly clientConfigs = {};
  constructor(
    private readonly minio: MinioService,
    private readonly configService: BackendConfigService,
  ) {
    this.BASE_BUCKET = configService.getEnv('MINIO_BUCKET');
    this.MINIO_ENDPOINT = configService.getEnv('MINIO_ENDPOINT');
    this.MINIO_PORT = configService.getEnv('MINIO_PORT');
  }

  client(name: string) {
    const client: MinioClient = new Client(this.clientConfigs[name]);
    return client;
  }

  public async upload(
    file: Express.Multer.File,
    type: string,
    customerId?: number,
    baseBucket: string = this.BASE_BUCKET,
  ) {
    const uploadFile = await getBufferAndFileNameFromFileUploadMulter(file);
    const tempFilename = Date.now().toString();
    const hashedFileName = crypto
      .createHash('md5')
      .update(tempFilename)
      .digest('hex');

    const ext = uploadFile.filename.substring(
      uploadFile.filename.lastIndexOf('.'),
      uploadFile.filename.length,
    );
    const metaData = {
      'Content-Type': uploadFile.mimetype,
    };
    const filename = hashedFileName + ext;
    const finalName = customerId
      ? `${type}/${customerId}/${filename}`
      : `${type}/${filename}`;
    const fileBuffer = uploadFile.buffer;
    // this.client('uploader').putObject(
    this.minio.client.putObject(
      baseBucket,
      finalName,
      fileBuffer,
      fileBuffer.length,
      metaData,
      function (err, res) {
        if (err) {
          throw new BaseException(Errors.BAD_REQUEST("Error upload"));
        }
      },
    );

    return {
      url: finalName,
    };
  }
  public async uploadFromBuffer(
    buffer: Buffer,
    type: string,
    filename: string,
    mimetype: string,
    baseBucket: string = this.BASE_BUCKET,
  ) {
    try {
      filename.substring(filename.lastIndexOf('.'), filename.length);
      const metaData = {
        'Content-Type': mimetype,
      };

      const finalName = `${type}/${filename}`;
      await this.minio.client.putObject(
        baseBucket,
        finalName,
        buffer,
        buffer.length,
        metaData
      );

      return {
        url: finalName,
      };
    } catch (error) {
      console.log(error)
      throw new BaseException(Errors.BAD_REQUEST("Error upload"));
    }
  }

  public async getObject(
    object: string,
    baseBucket: string = this.BASE_BUCKET,
  ) {
    return this.minio.client.getObject(baseBucket, object);
  }

  public async isObjectExist(object: string) {
    try {
      await this.minio.client.statObject(this.BASE_BUCKET, object);
      return await this.minio.client.presignedGetObject(
        this.BASE_BUCKET,
        object,
        parseInt(this.configService.getEnv('MINIO_SESSION_TIMEOUT')),
      );
    } catch (e) {
      console.log('Error when get file: ', e);
      return null;
    }
  }

  public async removeObject(
    object: string,
    baseBucket: string = this.BASE_BUCKET,
  ) {
    this.minio.client.removeObject(baseBucket, object, (err: any) => {
      if (err) console.log(err);
    });
  }
}
