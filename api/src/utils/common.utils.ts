import { customAlphabet } from 'nanoid';
import { ConfigService } from '@nestjs/config';
import moment from 'moment';
import { COMMON_CONSTANT } from 'src/constants/common.constant';
import { BackendConfigService } from 'src/services/backend-config.service';
import { RegexConstant } from 'src/constants/regex.constant';
import { MediaType } from '@prisma/client';

const configService = new BackendConfigService(new ConfigService());

export function getTimeFromNow(minutes = 0) {
  const now = new Date();
  now.setMinutes(now.getMinutes() + minutes);
  return now;
}

export function getDateFromNowByMonth(month = 0) {
  const now = new Date();
  now.setMonth(now.getMonth() + month);
  return now;
}

export function excludeObject<User, Key extends keyof User>(
  user: User,
  keys: Key[],
): Omit<User, Key> {
  for (const key of keys) {
    delete user[key];
  }
  return user;
}

export function _excludeObject(user: any, keys) {
  for (const key of keys) {
    delete user[key];
  }
  return user;
}

export function hasRequiredProperties(properties: Array<string>, obj) {
  return properties.every(
    (prop) => obj.hasOwnProperty(prop) && obj[prop] !== null,
  );
  // return obj.hasOwnProperty('type') && obj.hasOwnProperty('count');
}

export function _hasRequiredProperties<T, K extends keyof T>(properties, obj: T) {
  return properties.every(
    (prop) => obj.hasOwnProperty(prop) && obj[prop] !== null,
  );
  // return obj.hasOwnProperty('type') && obj.hasOwnProperty('count');
}

export function sortObject(obj) {
  let sorted = {};
  let str = [];
  let key;
  for (key in obj) {
    if (obj.hasOwnProperty(key)) {
      str.push(encodeURIComponent(key));
    }
  }
  str.sort();
  for (key = 0; key < str.length; key++) {
    sorted[str[key]] = encodeURIComponent(obj[str[key]]).replace(/%20/g, '+');
  }
  return sorted;
}

export function isEmptyObject(obj: object): boolean {
  return Object.keys(obj).length === 0;
}

export function generateCustomAlphaBet() {
  const nanoid = customAlphabet('1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ', 10);
  return nanoid()
}
export async function getSMSTemplate(template: string, data: any) {
  function replaceAll(str, find, replace) {
    return str.replace(new RegExp(find, 'g'), replace);
  }
  const keys = Object.keys(data);
  if (keys.length > 0) {
    for (const key of keys) {
      if (data[key]) {
        template = replaceAll(template, '<' + key + '>', data[key]);
      }
    }
  }
  return template;
}
export function getCreatedAtNotification() {
  return moment().format(COMMON_CONSTANT.NOTIFY_FORMAT_TIME);
}

export function parseQueryString(queryString: string): Record<string, string> {
  const params = new URLSearchParams(queryString);
  const result: Record<string, string> = {};

  params.forEach((value, key) => {
    result[key] = value;
  });

  return result;
}

export function mimeTypeToMediaType(mimeType: string) {
  console.log(mimeType)
  if (mimeType.match(RegexConstant.ImageReg))
    return MediaType.IMAGE
  if (mimeType.match(RegexConstant.VideoReg))
    return MediaType.VIDEO
  if (mimeType.match(RegexConstant.PdfReg))
    return MediaType.PDF
}

export function concatValueInObject(obj) {
  let result = '';

  for (let key in obj) {
    if (obj.hasOwnProperty(key)) {
      if (typeof obj[key] === 'string') {
        result += obj[key];
      }
    }
  }

  return result;
}
