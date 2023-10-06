/*
  Warnings:

  - You are about to drop the column `total_price` on the `reservation_transaction` table. All the data in the column will be lost.
  - You are about to drop the `_VendorToVendorType` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[setting_code]` on the table `configuration` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[reservation_id]` on the table `reservation_transaction` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[tour_booking_id]` on the table `tour_booking_transaction` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `price` to the `reservation_vendor` table without a default value. This is not possible if the table is not empty.
  - Added the required column `vendor_system_commission` to the `reservation_vendor` table without a default value. This is not possible if the table is not empty.
  - Added the required column `vendor_system_price` to the `reservation_vendor` table without a default value. This is not possible if the table is not empty.
  - Added the required column `total_price` to the `tour_booking` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tour_guide_commission` to the `tour_booking` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tour_system_commission` to the `tour_booking` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tour_system_price` to the `tour_booking` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `_VendorToVendorType` DROP FOREIGN KEY `_VendorToVendorType_A_fkey`;

-- DropForeignKey
ALTER TABLE `_VendorToVendorType` DROP FOREIGN KEY `_VendorToVendorType_B_fkey`;

-- AlterTable
ALTER TABLE `area` MODIFY `code` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `configuration` MODIFY `setting_value` INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE `reservation_transaction` DROP COLUMN `total_price`;

-- AlterTable
ALTER TABLE `reservation_vendor` ADD COLUMN `price` INTEGER NOT NULL,
    ADD COLUMN `vendor_system_commission` INTEGER NOT NULL,
    ADD COLUMN `vendor_system_price` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `tour_booking` ADD COLUMN `total_price` INTEGER NOT NULL,
    ADD COLUMN `tour_guide_commission` INTEGER NOT NULL,
    ADD COLUMN `tour_system_commission` INTEGER NOT NULL,
    ADD COLUMN `tour_system_price` INTEGER NOT NULL,
    MODIFY `total_adult` INTEGER NULL DEFAULT 0,
    MODIFY `total_children` INTEGER NULL DEFAULT 0;

-- DropTable
DROP TABLE `_VendorToVendorType`;

-- CreateTable
CREATE TABLE `VendorTypeRelation` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `vendorId` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `vendorTypeId` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `configuration_setting_code_key` ON `configuration`(`setting_code`);

-- CreateIndex
CREATE UNIQUE INDEX `reservation_transaction_reservation_id_key` ON `reservation_transaction`(`reservation_id`);

-- CreateIndex
CREATE UNIQUE INDEX `tour_booking_transaction_tour_booking_id_key` ON `tour_booking_transaction`(`tour_booking_id`);

-- AddForeignKey
ALTER TABLE `VendorTypeRelation` ADD CONSTRAINT `VendorTypeRelation_vendorId_fkey` FOREIGN KEY (`vendorId`) REFERENCES `vendor`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `VendorTypeRelation` ADD CONSTRAINT `VendorTypeRelation_vendorTypeId_fkey` FOREIGN KEY (`vendorTypeId`) REFERENCES `VendorType`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
