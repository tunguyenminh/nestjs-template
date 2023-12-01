import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import * as mongoose from 'mongoose';
import { Document } from 'mongoose';
import { User } from 'src/models/user/user.schema';
import { CallTypeStatus } from './call-type.enum';


export type CallTypeDocument = CallType & Document;

@Schema({
    timestamps: true,
    toJSON: {
        virtuals: true,
    },
    toObject: {
        virtuals: true,
    },
})
export class CallType {
    @Prop({ required: true, index: true })
    title?: string;

    @Prop({ required: false, index: true, default: 10 })
    price?: number;

    @Prop({ required: true, index: true, default: 30 })
    value: 30

    @Prop({
        required: true,
        index: true,
    })
    status: CallTypeStatus;

}

export const CallTypeSchema = SchemaFactory.createForClass(CallType);
