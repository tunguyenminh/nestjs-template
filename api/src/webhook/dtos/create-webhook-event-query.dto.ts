import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsNotEmpty, IsString } from 'class-validator';

export class CreateWebhookEventQueryDto {
    @ApiProperty({
        example: 'abc',
        required: true,
    })
    @IsString()
    @IsNotEmpty()
    readonly secret: string;
}