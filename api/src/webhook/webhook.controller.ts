import {
  Body,
  Controller,
  Post,
  Request,
} from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';


@ApiTags('Webhook')
@Controller()
export class WebhookController {
  constructor(
  ) { }

  @Post('/events/room/created')
  async createWebhookEvent(
    @Body() body,
  ) {
    console.log("testtttt", body)
    return true;
  }
}
