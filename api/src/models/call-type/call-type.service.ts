import { Injectable } from '@nestjs/common';
import { CallTypeFilterDto } from './dto/call-filter.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { filterTransform } from 'src/utils/common.utils';
import { Call, CallDocument } from '../call/call.schema';
import { CallFilterDto } from '../call/dto/call-filter.dto';
import { CallType, CallTypeDocument } from './call-type.schema';

@Injectable()
export class CallTypeService {
  constructor(
    @InjectModel(CallType.name) private readonly callModel: Model<CallTypeDocument>,

  ) { }
  async create(args: CallType) {
    await this.callModel.create({ ...args })
  }

  async createMany(args: Array<CallTypeFilterDto>) {
    await this.callModel.insertMany(args)
  }

  async findOne(filter?: CallTypeFilterDto,) {
    return this.callModel.findOne({ ...filterTransform(filter) })
  }

  async countDocument(filter?: CallTypeFilterDto) {
    return this.callModel.countDocuments({ ...filterTransform(filter) })
  }
}
