import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Query } from '@nestjs/common';
import { CallService } from './call.service';
import { CreateCallDto } from './dto/create-call.dto';
import { UpdateCallDto } from './dto/update-call.dto';
import { UserRole } from 'src/constants/enum.constant';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { JwtAuthGuard } from 'src/auth/guards/jwt-auth.guard';
import { User } from 'src/auth/decorators/user.decorator';
import { IUserJwt } from 'src/auth/strategies/jwt.strategy';
import { UserService } from '../user/user.service';
import { BaseException, Errors } from 'src/constants/error.constant';
import configurationCommon from 'src/common/configuration.common';
import { CallSortDto } from './dto/call-sort.dto';
import { CallTypeService } from '../call-type/call-type.service';
@ApiTags('Call')
@Controller('call')
export class CallController {
  constructor(
    private readonly callService: CallService,
    private readonly userService: UserService,
    private readonly callTypeService: CallTypeService
  ) { }

  @Post()
  async create(@Body() createCallDto: CreateCallDto, @User() user: IUserJwt) {
    const callType = await this.callTypeService.findOne({ _id: createCallDto.type })
    if (!callType)
      throw new BaseException(Errors.BAD_REQUEST("Call type not found"));

    return this.callService.create({ ...createCallDto, type: callType, user: user.data.id || null });
  }

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @Get()
  async findAll(@Query() query: any, @User() user: IUserJwt) {
    const userFound = await this.userService.findOne({ id: user.data.id })
    if (!userFound)
      throw new BaseException(Errors.BAD_REQUEST("User not found"));

    const page =
      query &&
        query.page &&
        Number.isSafeInteger(Number(query.page)) &&
        Number(query.page) > 0
        ? Number(query.page)
        : 1;
    const pageSize =
      query &&
        query.pageSize &&
        Number.isSafeInteger(Number(query.pageSize)) &&
        Number(query.pageSize) > 0
        ? Number(query.pageSize)
        : 10;
    const sortBy =
      query &&
        query.sort &&
        query.sort.trim() &&
        query.sort.trim().split(':').length == 2
        ? query.sort.trim().split(':')
        : null;

    const sortableFields = [
      'title',
      'status',
      ...(configurationCommon().commonSortFields || []),
    ];
    let callSort: CallSortDto = null;
    if (
      sortBy &&
      sortBy.length == 2 &&
      sortableFields.includes(sortBy[0].trim()) &&
      ['ASC', 'DESC'].includes(sortBy[1].trim().toUpperCase())
    ) {
      callSort = {
        [sortBy[0]]: sortBy[1].trim().toUpperCase() === 'ASC' ? 1 : -1,
      };
    }

    let filter = {}
    if (query.searchText) {
      filter = {
        ...filter,
        name: new RegExp(query.searchText, 'i'),
      };
    }

    const totalCall = await this.callService.countDocument(filter)
    const totalPage = Math.ceil(totalCall / pageSize);
    const callList =
      page > 0 && page <= totalPage
        ? await this.callService.query({ page, pageSize }, callSort, filter)
        : [];
    return {
      data: callList,
      paging: {
        page,
        pageSize,
        totalPage,
        nextPage: page + 1 <= totalPage ? page + 1 : null,
        prevPage: page - 1 >= 1 ? page - 1 : null,
        total: totalCall,
      },
    }
  }

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.callService.findOne({ id });
  }
}
