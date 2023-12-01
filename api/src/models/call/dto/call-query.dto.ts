import { ApiProperty } from "@nestjs/swagger";
import { Type } from "class-transformer";
import { Min, IsNumber, IsOptional, Max, IsString, NotContains, IsEnum } from "class-validator";
import { PagingDto } from "src/base/base.model";
import { FilterOptions } from "src/base/filterOption.dto";
import { CallStatus } from "../call.enum";

export class CallQueryDto {
    @ApiProperty({
        description: 'Minimum value 1',
        example: 1,
        required: false,
        default: 1,
        minimum: 1,
    })
    @Type(() => Number)
    @Min(1)
    @IsNumber()
    @IsOptional()
    readonly page?: number;

    @ApiProperty({
        description: 'Minimum value 1 - Maximum value 50',
        example: 10,
        required: false,
        default: 10,
        maximum: 50,
        minimum: 1,
    })
    @Type(() => Number)
    @Min(1)
    @Max(50)
    @IsNumber()
    @IsOptional()
    readonly pageSize?: number;

    @ApiProperty({
        example: 'createdAt:DESC',
        required: false,
    })
    @IsString()
    @IsOptional()
    readonly sort?: string;

    @ApiProperty({
        example: '63db320e6fd9b1a6afe8538c',
        required: false,
    })
    @IsOptional()
    @IsString()
    @NotContains(' ')
    readonly callType?: string;

    @ApiProperty({
        example: 'abc',
        required: false,
    })
    @IsOptional()
    @IsString()
    readonly phoneNumber?: string;

    @ApiProperty({
        example: 'abc',
        required: false,
    })
    @IsOptional()
    @IsEnum(CallStatus)
    readonly status?: CallStatus;

    @ApiProperty({
        example: 'abc',
        required: false,
    })
    @IsOptional()
    @IsString()
    readonly searchText?: string;

    @ApiProperty({
        example: '2022-10-31T09:41:13.415Z',
        required: false,
    })
    @IsString()
    @IsOptional()
    readonly startDate?: string;

    @ApiProperty({
        example: '2022-10-31T09:41:13.415Z',
        required: false,
    })
    @IsString()
    @IsOptional()
    readonly endDate?: string;
}