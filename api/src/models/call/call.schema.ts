import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import * as mongoose from 'mongoose';
import { Document } from 'mongoose';
import { User } from 'src/models/user/user.schema';


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

    @Prop({})
    avatar?: string;

    @Prop({})
    phoneNumber?: string;

    @Prop({
        required: true,
        index: true,
    })
    status: string;

    @Prop({
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        index: true,
    })
    user: User;

}

export const CallSchema = SchemaFactory.createForClass(Call);
