import { Test, TestingModule } from '@nestjs/testing';
import { CallTypeService } from './call-type.service';

describe('CallTypeService', () => {
  let service: CallTypeService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [CallTypeService],
    }).compile();

    service = module.get<CallTypeService>(CallTypeService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
