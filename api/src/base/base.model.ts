export interface BaseModel {
  id: number;

  createdAt: Date;
  updatedAt: Date;
}

export interface PagingDto {
  readonly page?: number;
  readonly pageSize?: number;
}
