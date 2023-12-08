import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Query, Put } from '@nestjs/common';
import { CallService } from './call.service';
import { CreateCallDto, JoinCallDto } from './dto/create-call.dto';
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
import { Roles } from 'src/auth/decorators/roles.decorator';
import { CallQueryDto } from './dto/call-query.dto';
import { checkValidPhoneAndTransform, generateCustomAlphaBet } from 'src/utils/common.utils';
import { CallStatus } from './call.enum';
import { UpdateCallDto } from './dto/update-call.dto';
import moment from 'moment';

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

    const phoneNumber = checkValidPhoneAndTransform(createCallDto.phoneNumber)

    const callType = await this.callTypeService.findOne({ _id: createCallDto.type })
    if (!callType)
      throw new BaseException(Errors.BAD_REQUEST("Call type not found"));

    return this.callService.create({ ...createCallDto, phoneNumber, type: callType, user: user?.data?._id, source: generateCustomAlphaBet(), status: CallStatus.PENDING, totalMinute: callType.value, minuteLeft: callType.value });
  }

  @Put(":id")
  async updateCall(@Param('id') id: string, @Body() body: UpdateCallDto, @User() user: IUserJwt) {
    const call = await this.callService.findOne({ _id: id })
    if (!call)
      throw new BaseException(Errors.BAD_REQUEST("Call not found"));
    if (body.type) {

      const callType = await this.callTypeService.findOne({ _id: body.type })
      let { type, ...args } = body
      if (!callType)
        throw new BaseException(Errors.BAD_REQUEST("Call type not found"));
      return this.callService.update(id, {
        ...args, type: callType,
        totalMinute: callType.value,
        minuteLeft: callType.value
      })
    }
    return this.callService.update(id, body)
  }

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @Roles(UserRole.ADMIN, UserRole.USER)
  @Get()
  async findAll(@Query() query: CallQueryDto, @User() user: IUserJwt) {
    const userFound = await this.userService.findOne({ _id: user.data._id })
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
    if (user.data.role == UserRole.USER) {
      filter = {
        ...filter,
        phoneNumber: user.data?.phoneNumber
      }
    }

    if (query.searchText) {
      filter = {
        ...filter,
        $or: [
          { phoneNumber: new RegExp(query.searchText, 'gi') },
          { userEmail: new RegExp(query.searchText, 'gi') },
          { title: new RegExp(query.searchText, 'gi') },
          { 'user.username': new RegExp(query.searchText, 'gi') },
          { 'callType.title': new RegExp(query.searchText, 'gi') },
          { 'user.phoneNumber': new RegExp(query.searchText, 'gi') },
          { 'user.email': new RegExp(query.searchText, 'gi') },
        ]
      }
    }

    if (query.isCalling) {
      if (query.isCalling == 1) {
        filter = {
          ...filter,
          isCalling: true
        }
      }
      else {
        filter = {
          ...filter,
          isCalling: false
        }
      }
    }

    if (
      query.startDate &&
      moment(query.startDate).isValid() &&
      query.endDate &&
      moment(query.endDate).isValid()
    ) {
      filter = {
        ...filter,
        appointmentDate: {
          $gte: new Date(moment(query.startDate).startOf('date').toISOString()),
          $lt: new Date(moment(query.endDate).endOf('date').toISOString()),
        },
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

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return (await this.callService.findOne({ _id: id })).populate("user");
  }

  @Post('join-call')
  async joinCall(@Body() body: JoinCallDto) {
    const call = await this.callService.findOne({ _id: body.callId, $or: [{ userEmail: body.username }, { phoneNumber: body.username }] })
    if (!call) throw new BaseException(Errors.BAD_REQUEST("Call not found"))
    // if (call.minuteLeft = 0) throw new BaseException(Errors.BAD_REQUEST("Your time has ended"))
    // if (moment(call.appointmentDate).isBefore(moment())) throw new BaseException(Errors.BAD_REQUEST("It's not time to start yet"))
    return call
  }



  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @Roles(UserRole.ADMIN)
  @Delete(':id')
  async delete(@Param('id') id: string) {
    return await this.callService.update(id, { status: CallStatus.DELETED })
  }
}
