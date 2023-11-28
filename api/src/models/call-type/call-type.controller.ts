import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { CallTypeService } from './call-type.service';

@Controller('call-type')
export class CallTypeController {
  constructor(private readonly callTypeService: CallTypeService) { }

  @Post()
  create(@Body() createCallTypeDto) {
    return this.callTypeService.create(createCallTypeDto);
  }



}
