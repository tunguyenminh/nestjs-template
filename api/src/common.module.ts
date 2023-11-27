import { ConfigService } from '@nestjs/config';
import { BackendConfigService } from './services/backend-config.service';
import { Global, Module } from '@nestjs/common';
import { FirebaseService } from './services/firebase.service';

const providers = [BackendConfigService, ConfigService, FirebaseService];

@Global()
@Module({
  providers,
  exports: [...providers],

})
export class CommonModule { }
