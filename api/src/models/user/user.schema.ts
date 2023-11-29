import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import * as mongoose from 'mongoose';
import { Document } from 'mongoose';
import { Gender, UserRole, UserStatus } from 'src/constants/enum.constant';


export type UserDocument = User & Document;

@Schema({
  timestamps: true,
  toJSON: {
    virtuals: true,
  },
  toObject: {
    virtuals: true,
  },
})
export class User {
  @Prop({ required: true, unique: true, index: true })
  username: string;

  @Prop({ required: true, default: UserStatus.ACTIVE })
  status: UserStatus;

  @Prop({ required: true, unique: true, index: true })
  email: string;

  @Prop({ required: true, select: false })
  password: string;

  @Prop({})
  avatar?: string;

  @Prop({})
  dob?: Date;

  @Prop({})
  gender?: Gender;

  @Prop({})
  phoneNumber?: string;

  @Prop({})
  userRole: UserRole;

}

export const UserSchema = SchemaFactory.createForClass(User);
