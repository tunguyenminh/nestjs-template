import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model, PipelineStage } from 'mongoose';

import { User, UserDocument } from './user.schema';
import { UserFilterDto } from './dtos/user-filter.dto';
import { filterTransform } from 'src/utils/common.utils';


@Injectable()
export class UserService {
  constructor(
    @InjectModel(User.name) private readonly userModel: Model<UserDocument>,

  ) { }
  async create(createUserDto: UserFilterDto) {
    return await this.userModel.create({ ...createUserDto })
  }

  async createMany(args: Array<UserFilterDto>) {
    await this.userModel.insertMany(args)
  }

  async findOne(filter?: UserFilterDto,) {
    return this.userModel.findOne({ ...filterTransform(filter) })
  }

  async findOneIncludePassword(filter?: UserFilterDto,) {
    return this.userModel.findOne({ ...filterTransform(filter) }).select("+password")
  }

  async update(id: string, updateUserDto: any) {
    const updatedDoc = await this.userModel.findByIdAndUpdate(
      id,
      {
        $set: updateUserDto,
      },
      { new: true },
    );
    return (updatedDoc && updatedDoc.toObject()) || null;
  }
}
