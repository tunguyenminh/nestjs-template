import { ApiProperty } from "@nestjs/swagger";
import { IsString, IsNotEmpty, NotContains, IsOptional, IsMongoId } from "class-validator";

export class CreateCallDto {
    @ApiProperty({
        example: 'username',
    })
    @IsString()
    @IsNotEmpty()
    readonly title: string;

    @ApiProperty({
        example: 'objectId',
    })
    @IsString()
    @IsNotEmpty()
    @IsMongoId()
    @NotContains(' ')
    readonly type: string;

    @ApiProperty({
        example: 'objectId',
    })
    @IsString()
    @IsNotEmpty()
    @NotContains(' ')
    readonly userEmail: string;

    @ApiProperty({
        example: 'objectId',
    })
    @IsString()
    @IsNotEmpty()
    @NotContains(' ')
    readonly phoneNumber: string;

    @ApiProperty({
        example: '2022-10-31T09:41:13.415Z',
        required: false,
    })
    @IsString()
    @IsOptional()
    readonly appointmentDate?: string;
}

export class JoinCallDto {
    @ApiProperty({
        example: 'id',
    })
    @IsString()
    @IsNotEmpty()
    readonly callId: string;

    @ApiProperty({
        example: 'id',
    })
    @IsString()
    @IsNotEmpty()
    readonly username: string;
}
