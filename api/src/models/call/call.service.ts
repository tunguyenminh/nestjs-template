import { Injectable } from '@nestjs/common';
import { CreateCallDto } from './dto/create-call.dto';
import { UpdateCallDto } from './dto/update-call.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { filterTransform } from 'src/utils/common.utils';
import { UserFilterDto } from '../user/dtos/user-filter.dto';
import { User, UserDocument } from '../user/user.schema';
import { Call, CallDocument } from './call.schema';
import { CallFilterDto } from './dto/call-filter.dto';
import { PagingDto } from 'src/base/base.model';
import { CallSortDto } from './dto/call-sort.dto';
import { CallStatus } from './call.enum';

@Injectable()
export class CallService {
  constructor(
    @InjectModel(Call.name) private readonly callModel: Model<CallDocument>,

  ) { }
  async create(args: CallFilterDto) {
    return await this.callModel.create({ ...args })
  }

  async createMany(args: Array<CallFilterDto>) {
    return await this.callModel.insertMany(args)
  }

  async findOne(filter?: CallFilterDto,) {
    return this.callModel.findOne({ ...filterTransform(filter) })
  }

  async countDocument(filter?: CallFilterDto) {
    return this.callModel.countDocuments({ ...filterTransform(filter) })
  }

  async update(id: string, dto: any) {
    const updatedDoc = await this.callModel.findByIdAndUpdate(
      id,
      {
        $set: dto,
      },
      { new: true },
    );
    return (updatedDoc && updatedDoc.toObject()) || null;
  }
  async query(
    paging: PagingDto = { page: 1, pageSize: 10 },
    sort?: CallSortDto,
    filter?: CallFilterDto,
  ) {
    const { page = 1, pageSize = 10 } = paging;

    return (
      await this.callModel
        .find({
          ...filterTransform(filter),
          status: { $ne: CallStatus.DELETED },
        })
        .sort({ ...(sort || { createdAt: -1 }) })
        .skip((page - 1) * pageSize)
        .limit(pageSize)
    ).map((item) => item.toObject());
  }
}
