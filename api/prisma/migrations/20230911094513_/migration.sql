/*
  Warnings:

  - You are about to drop the column `end_serve_day` on the `vendor` table. All the data in the column will be lost.
  - You are about to drop the column `end_serve_time` on the `vendor` table. All the data in the column will be lost.
  - You are about to drop the column `start_serve_day` on the `vendor` table. All the data in the column will be lost.
  - You are about to drop the column `start_serve_time` on the `vendor` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `tour` ADD COLUMN `fix_cost` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `max_customer` INTEGER NULL,
    ADD COLUMN `min_customer` INTEGER NOT NULL DEFAULT 1;

-- AlterTable
ALTER TABLE `tour_booking` ADD COLUMN `fix_cost` INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE `vendor` DROP COLUMN `end_serve_day`,
    DROP COLUMN `end_serve_time`,
    DROP COLUMN `start_serve_day`,
    DROP COLUMN `start_serve_time`;

-- CreateTable
CREATE TABLE `time_in_week_vendor_open` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `vendor_id` INTEGER NOT NULL,
    `day_of_week` INTEGER NOT NULL,
    `index` INTEGER NOT NULL DEFAULT 1,
    `start` TIME NULL,
    `end` TIME NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `time_in_week_vendor_open` ADD CONSTRAINT `time_in_week_vendor_open_vendor_id_fkey` FOREIGN KEY (`vendor_id`) REFERENCES `vendor`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
