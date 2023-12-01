import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';

export class WebhookEventCreateRoom {
  readonly event_name?: string;
  readonly created_at?: number;
  readonly room_jid?: string;
  readonly is_breakout?: boolean;
  readonly room_name?: string;
}

export class WebhookEventJoinedRoom {
  readonly event_name?: string;
  readonly room_jid?: string;
  readonly room_name?: string;
  readonly occupant: {
    joined_at: number,
    occupant_jid: string
  };
  readonly is_breakout?: boolean
}

export class WebhookEventLeftRoom {
  readonly event_name?: string;
  readonly room_jid: string;
  readonly room_name?: string;
  readonly occupant: {
    joined_at: number,
    occupant_jid: string,
    left_at: number
  };
  is_breakout: boolean
}

export class WebhookEventDestroyedRoom {
  is_breakout: boolean;
  all_occupants: [
    {
      left_at: number,
      joined_at: number,
      occupant_jid: string
    }
  ];
  destroyed_at: number;
  created_at: number;
  room_jid: string;
  room_name: string;
  event_name: string
}

