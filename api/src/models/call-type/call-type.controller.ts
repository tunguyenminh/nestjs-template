import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { CallTypeService } from './call-type.service';
import { CallTypeStatus } from './call-type.enum';
import { ApiTags } from '@nestjs/swagger';
@ApiTags("Call type")
@Controller('call-type')
export class CallTypeController {
  constructor(private readonly callTypeService: CallTypeService) { }

  @Post()
  async create(@Body() createCallTypeDto) {
    return this.callTypeService.create(createCallTypeDto);
  }

  @Get()
  async getList() {
    return this.callTypeService.findOne({ status: { $ne: CallTypeStatus.DELETED } })
  }

}
