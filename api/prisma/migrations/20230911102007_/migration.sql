/*
  Warnings:

  - You are about to drop the `time_in_week_vendor_open` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `time_in_week_vendor_open` DROP FOREIGN KEY `time_in_week_vendor_open_vendor_id_fkey`;

-- DropTable
DROP TABLE `time_in_week_vendor_open`;

-- CreateTable
CREATE TABLE `vendor_serving` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `vendor_id` INTEGER NOT NULL,
    `day_of_week` INTEGER NOT NULL,
    `index` INTEGER NOT NULL DEFAULT 1,
    `start` TIME NULL,
    `end` TIME NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `vendor_serving` ADD CONSTRAINT `vendor_serving_vendor_id_fkey` FOREIGN KEY (`vendor_id`) REFERENCES `vendor`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
