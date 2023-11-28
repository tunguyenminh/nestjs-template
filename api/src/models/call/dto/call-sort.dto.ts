import { SortOrder } from 'mongoose';

export class CallSortDto {
  readonly title?: SortOrder;
  readonly status?: SortOrder;
  readonly createdAt?: SortOrder;
  readonly updatedAt?: SortOrder;
}
