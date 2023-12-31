import { Controller, Get, Headers, Param } from '@nestjs/common';
import { AppService } from './app.service';
import { BaseException, Errors } from './constants/error.constant';
import {
  getProvinces,
  getDistrictsByProvince,
  getWardsByDistrict,
  getWards,
  getDistricts,
} from './utils/location.utils';
import subVn from 'sub-vi';
import { PrismaService } from 'prisma/prisma.service';
import phoneCode from 'country-codes-list';
import { I18n, I18nContext } from 'nestjs-i18n';
import { I18nCustomService } from './i18n/i18n.service';
@Controller()
export class AppController {
  constructor(
    private readonly appService: AppService,
    private readonly prismaService: PrismaService,
    private readonly i18n: I18nCustomService,
  ) { }

  @Get()
  async getHello(
    @Headers() headers: any,
  ) {
    // const test = await i18n.t('translation.welcome.abc')
    const test = await this.i18n.t('common-message.test-fall-back')
    throw new BaseException(Errors.BAD_REQUEST(await this.i18n.t("common-message.test-fall-back")))
    return { message: test };
  }

  @Get('areas')
  async getAreas() {
    try {
      return this.prismaService.area.findMany({});
    } catch (error) {
      console.log(error);
      return error;
    }
  }

  @Get('province-codes')
  async getProvinceCodes() {
    try {
      return getProvinces();
    } catch (error) {
      console.log(error);
      return error;
    }
  }

  @Get(':provinceCode/district-by-province')
  getDistrictsByProvince(@Param('provinceCode') param: string) {
    try {
      return getDistrictsByProvince(param);
    } catch (error) {
      return error;
    }
  }

  @Get(':districtCode/wards-by-district')
  getWardsByDistrict(@Param('districtCode') param: string) {
    try {
      return getWardsByDistrict(param);
    } catch (error) {
      return error;
    }
  }

  @Get('get-phone-code')
  getPhoneCode() {
    try {
      const phoneCodes = phoneCode.all();
      return phoneCodes.map((x) => {
        return {
          countryNameEn: x.countryNameEn,
          countryCode: x.countryCode,
          countryCallingCode: x.countryCallingCode,
          flag: x.flag,
        };
      });
    } catch (error) {
      return error;
    }
  }

  @Get('get-vendor-type')
  async getVendorTypes() {
    return this.prismaService.vendorType.findMany({});
  }
}
