import { Test, TestingModule } from '@nestjs/testing';
import { CallTypeController } from './call-type.controller';
import { CallTypeService } from './call-type.service';

describe('CallTypeController', () => {
  let controller: CallTypeController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [CallTypeController],
      providers: [CallTypeService],
    }).compile();

    controller = module.get<CallTypeController>(CallTypeController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
