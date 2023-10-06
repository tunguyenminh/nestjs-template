import path from 'path';
import fs from 'fs';
import moment from 'moment';

export const getUploadPath = (rootPath: string) => {
  const pathYear = path.join(
    rootPath,
    moment().get('year').toString(),
  );

  const pathMonth = path.join(
    pathYear,
    (moment().get('month') + 1).toString(),
  );
  const pathDay = path.join(
    pathMonth,
    moment().get('day').toString(),
  );
  if (!fs.existsSync(pathYear)) {
    fs.mkdirSync(pathYear, { recursive: true });
  }
  if (!fs.existsSync(pathMonth)) {
    fs.mkdirSync(pathMonth);
  }
  if (!fs.existsSync(pathDay)) {
    fs.mkdirSync(pathDay);
  }

  return pathDay;
};