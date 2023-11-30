import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';

export class CreateWebhookEventDto {
  readonly uniqueid?: string;
  readonly linkedid?: string;
  readonly callid: string;
  readonly channel?: string;
  readonly extend?: string;
  readonly state?: string;
  readonly phone: string;
  readonly type: string;
  readonly note?: string;
  readonly cdr?: {
    readonly source?: string;
    readonly destination?: string;
    readonly starttime?: string;
    readonly answertime?: string;
    readonly endtime?: string;
    readonly duration?: string;
    readonly billsec?: string;
    readonly disposition?: string;
  };
}
