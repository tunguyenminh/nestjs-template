import { ApiProperty } from "@nestjs/swagger";
import { IsString, IsNotEmpty, NotContains } from "class-validator";

export class CreateCallDto {
    @ApiProperty({
        example: 'username',
    })
    @IsString()
    @IsNotEmpty()
    @NotContains(' ')
    readonly title: string;

    @ApiProperty({
        example: 'objectId',
    })
    @IsString()
    @IsNotEmpty()
    @NotContains(' ')
    readonly type: string;

}
