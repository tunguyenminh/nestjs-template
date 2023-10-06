/*
  Warnings:

  - You are about to drop the column `closing_day` on the `vendor` table. All the data in the column will be lost.
  - You are about to drop the column `closing_time` on the `vendor` table. All the data in the column will be lost.
  - You are about to drop the column `opening_day` on the `vendor` table. All the data in the column will be lost.
  - You are about to drop the column `opening_time` on the `vendor` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `tour_guide` ADD COLUMN `phone_emergency_code` VARCHAR(191) NULL,
    MODIFY `isActive` BOOLEAN NULL DEFAULT false;

-- AlterTable
ALTER TABLE `user` ALTER COLUMN `phone_code` DROP DEFAULT;

-- AlterTable
ALTER TABLE `vendor` DROP COLUMN `closing_day`,
    DROP COLUMN `closing_time`,
    DROP COLUMN `opening_day`,
    DROP COLUMN `opening_time`,
    ADD COLUMN `serve_time` VARCHAR(191) NULL,
    ADD COLUMN `sever_day` VARCHAR(191) NULL;
