/*
  Warnings:

  - You are about to drop the column `system_price` on the `tour` table. All the data in the column will be lost.
  - You are about to drop the column `system_price` on the `vendor` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `tour` DROP COLUMN `system_price`;

-- AlterTable
ALTER TABLE `vendor` DROP COLUMN `system_price`;

-- CreateTable
CREATE TABLE `configuration` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `setting_name` VARCHAR(191) NULL,
    `setting_code` VARCHAR(191) NULL,
    `setting_value` INTEGER NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
