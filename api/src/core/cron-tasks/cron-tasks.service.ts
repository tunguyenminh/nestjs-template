import { Injectable } from '@nestjs/common';
import { Cron, Timeout } from '@nestjs/schedule';
import axios from 'axios';

@Injectable()
export class CronTasksService {
  constructor(
    private read
  ) { }
  async updateExpiredTransaction() {
    await this
  }
}
