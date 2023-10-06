import { hash } from 'bcryptjs';
import { PrismaService } from '../prisma/prisma.service';

import { faker } from '@faker-js/faker';
import { Tour, UserRole, UserStatus } from '@prisma/client';
import subVn from 'sub-vi';
const prismaService = new PrismaService();
async function initial() {
  // delete if exist
  //create user admin
  await prismaService.user.createMany({
    data: [
      {
        username: 'admin01',
        password: await hash('123456', 10),
        fullName: 'admin01',
        phone: '099999999',
        email: 'admin01@gmail.com',
        userType: UserRole.ADMIN,
        userStatus: UserStatus.ACTIVE,
        avatar: 'string.com',
      },
      {
        username: 'admin02',
        password: await hash('123456', 10),
        fullName: 'admin02',
        phone: faker.phone.number.toString(),
        email: 'admin02@gmail.com',
        userType: UserRole.ADMIN,
        userStatus: UserStatus.ACTIVE,
        avatar: 'string.com',
      },
      {
        username: 'admin03',
        password: await hash('123456', 10),
        fullName: 'admin03',
        phone: faker.phone.number.toString(),
        email: 'admin01@gmail.com',
        userType: UserRole.ADMIN,
        userStatus: UserStatus.ACTIVE,
        avatar: 'string.com',
      },
      {
        username: 'admin04',
        password: await hash('123456', 10),
        fullName: 'admin04',
        phone: faker.phone.number.toString(),
        email: 'admin02@gmail.com',
        userType: UserRole.ADMIN,
        userStatus: UserStatus.ACTIVE,
        avatar: 'string.com',
      },
      {
        username: 'admin05',
        password: await hash('123456', 10),
        fullName: 'admin04',
        email: 'admin02@gmail.com',
        userType: UserRole.ADMIN,
        userStatus: UserStatus.ACTIVE,
        avatar: 'string.com',
      },
    ],
  });

  const provinces: Array<any> = subVn.getProvinces();
  const areaInsert = provinces.map((x) => {
    return {
      name: x.name,
      areaCode: x.area_code,
      areaName: x.area_name,
      code: x.code,
    };
  });
  await prismaService.area.createMany({
    data: areaInsert,
  });

  await prismaService.tourCategory.createMany({
    data: [
      {
        name: 'Sight seeing tours',
        thumbnail: 'https://placehold.co/200',
        description: 'Description',
      },
      {
        name: 'Food tours',
        thumbnail: 'https://placehold.co/200',
        description: 'Description',
      },
      {
        name: 'Get away tours',
        thumbnail: 'https://placehold.co/200',
        description: 'Description',
      },
      {
        name: 'Nightlife tours',
        thumbnail: 'https://placehold.co/200',
        description: 'Description',
      },
      {
        name: 'Entertainment tours',
        thumbnail: 'https://placehold.co/200',
        description: 'Description',
      },
    ],
  });

  await prismaService.user.create({
    data: {
      username: 'username',
      password: await hash('123456', 10),
      fullName: 'admin04',
      phone: '0911111111',
      email: 'admin02@gmail.com',
      userType: UserRole.CUSTOMER,
      userStatus: UserStatus.ACTIVE,
      avatar: 'string.com',
    },
  });

  await prismaService.tour.createMany({
    data: [
      {
        name: 'Tour du lịch 1',
        description: 'Mô tả',
        thumbnail: 'https://placehold.co/200',
        numberOfDays: 2,
        numberOfNights: 1,
        priceForChildren: 10000,
        priceForAdult: 100,
        areaId: 1,
      },
      {
        name: 'Tour du lịch 3',
        description: 'Mô tả',
        thumbnail: 'https://placehold.co/200',
        numberOfDays: 7,
        numberOfNights: 6,
        priceForChildren: 10000,
        priceForAdult: 100,
        areaId: 1,
      },
      {
        name: 'Tour du lịch 5',
        description: 'Mô tả',
        thumbnail: 'https://placehold.co/200',
        numberOfDays: 2,
        numberOfNights: 1,
        priceForChildren: 10000,
        priceForAdult: 100,
        areaId: 1,
      },
      {
        name: 'Tour du lịch 4',
        description: 'Mô tả',
        thumbnail: 'https://placehold.co/200',
        numberOfDays: 2,
        numberOfNights: 1,
        priceForChildren: 10000,
        priceForAdult: 100,
        areaId: 1,
      },
    ],
  });
}

initial().catch((err) => {
  console.log(err);
  process.exit(1);
});
