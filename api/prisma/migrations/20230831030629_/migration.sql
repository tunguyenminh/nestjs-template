/*
  Warnings:

  - A unique constraint covering the columns `[device_key]` on the table `device` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `device` MODIFY `other_information` VARCHAR(191) NULL;

-- CreateIndex
CREATE UNIQUE INDEX `device_device_key_key` ON `device`(`device_key`);
