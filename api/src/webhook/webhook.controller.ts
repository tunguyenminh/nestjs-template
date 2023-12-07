import {
  Body,
  Controller,
  Get,
  Post,
  Request,
} from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { WebhookEventCreateRoom, WebhookEventDestroyedRoom, WebhookEventJoinedRoom, WebhookEventLeftRoom } from './dtos';
import { CallService } from 'src/models/call/call.service';
import { CallStatus } from 'src/models/call/call.enum';
import moment from 'moment';

@ApiTags('Webhook')
@Controller()
export class WebhookController {
  constructor(
    private readonly callService: CallService,

  ) { }

  @Post('/events/room/created')
  async createdRoomWebhookEvent(
    @Body() body: WebhookEventCreateRoom,
  ) {
    const call = await this.callService.findOne({ id: body.room_name, status: CallStatus.ACCEPTED })

    if (call) {
      await this.callService.update(call.id, {
        isStarted: true,
        isCalling: true,
        startTime: moment(
          body.created_at * 1000, //convert to mls
          'YYYY-MM-DD hh:mm:ss',
        ).toISOString(),
      })
    }
    return true;
  }

  @Post('/events/room/joined')
  async joinedRoomWebhookEvent(
    @Body() body: WebhookEventJoinedRoom,
  ) {
    console.log("joined", body)
  }

  @Post('/events/room/destroyed')
  async destroyedRoomWebhookEvent(
    @Body() body: WebhookEventDestroyedRoom,
  ) {
    const call = await this.callService.findOne({ id: body.room_name, status: CallStatus.ACCEPTED })
    if (call) {
      await this.callService.update(call.id, {
        isCalling: false,
        endTime: moment(
          body.destroyed_at * 1000, //convert to mls
          'YYYY-MM-DD hh:mm:ss',
        ).toDate(),
      })
    }
    return true;
  }

  @Post('/events/room/left')
  async leftRoomWebhookEvent(
    @Body() body: WebhookEventLeftRoom,
  ) {
    const call = await this.callService.findOne({ id: body.room_name, status: CallStatus.ACCEPTED })
    if (call) {
      const callMinutes = body.occupant.left_at - body.occupant.left_at
      await this.callService.update(call.id, {
        minuteLeft: call.totalMinute - callMinutes * 60
      })
    }
    return true;
  }
}