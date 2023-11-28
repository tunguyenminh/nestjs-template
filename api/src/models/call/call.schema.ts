import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import * as mongoose from 'mongoose';
import { Document } from 'mongoose';
import { User } from 'src/models/user/user.schema';
import { CallStatus } from './call.enum';
import { CallType } from '../call-type/call-type.schema';


export type CallDocument = Call & Document;

@Schema({
    timestamps: true,
    toJSON: {
        virtuals: true,
    },
    toObject: {
        virtuals: true,
    },
})
export class Call {
    @Prop({ required: false, index: true })
    title?: string;

    @Prop({})
    recording: string;

    @Prop({
        required: false,
    })
    source?: string;

    @Prop({
        required: true,
        index: true,
    })
    status: CallStatus;

    @Prop({
        required: true,
        index: true,
    })
    type: CallType;

    @Prop({
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        index: true,
    })
    user: User;

}

export const CallSchema = SchemaFactory.createForClass(Call);
