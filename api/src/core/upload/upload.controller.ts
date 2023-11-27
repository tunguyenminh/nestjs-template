import {
  Controller,
  FileTypeValidator,
  MaxFileSizeValidator,
  ParseFilePipe,
  Post,
  UploadedFile,
  UploadedFiles,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor, FilesInterceptor } from '@nestjs/platform-express';
import { ApiBearerAuth, ApiBody, ApiConsumes, ApiTags } from '@nestjs/swagger';
import { RegexConstant } from 'src/constants/regex.constant';
import { mimeTypeToMediaType } from 'src/utils/common.utils';

// import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';

@ApiTags('Upload')
@Controller('upload')
export class UploadController {
  // @ApiBearerAuth()
  // @UseGuards(JwtAuthGuard)
  @Post('')
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema: {
      type: 'object',
      properties: {
        files: {
          type: 'array',
          items: {
            type: 'string',
            format: 'binary',
          },
        },
      },
      required: ['files'],
    },
  })
  @UseInterceptors(FilesInterceptor('files', 100))
  async uploadFiles(@UploadedFiles(
  ) files: Array<Express.Multer.File>) {
    return {
      data: files.map((file) => ({
        uri: `${file.destination.split('/public/')[1]}/${file.filename}`,
        fileType: mimeTypeToMediaType(file.mimetype)
      })),
    };
  }

  // @ApiBearerAuth()
  // @UseGuards(JwtAuthGuard)
  @Post('/single')
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema: {
      type: 'object',
      properties: {
        file: {
          type: 'string',
          format: 'binary',
        },
      },
      required: ['file'],
    },
  })
  @UseInterceptors(FileInterceptor('file'))
  async uploadFile(@UploadedFile() file: Express.Multer.File) {
    console.log("file", file)
    return {
      uri: `${file.destination.split('/public/')[1]}/${file.filename}`,
      fileType: mimeTypeToMediaType(file.mimetype)
    };
  }
}
