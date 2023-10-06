/*
  Warnings:

  - The values [NA,FAILED] on the enum `tour_booking_transaction_status` will be removed. If these variants are still used in the database, this will fail.
  - The values [NA,FAILED] on the enum `tour_booking_transaction_status` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `serve_day` on the `vendor` table. All the data in the column will be lost.
  - You are about to drop the `reservation_unit` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `unit` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `total_slot` to the `vendor` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `reservation_transaction` DROP FOREIGN KEY `reservation_transaction_reservation_id_fkey`;

-- DropForeignKey
ALTER TABLE `reservation_unit` DROP FOREIGN KEY `reservation_unit_customer_id_fkey`;

-- DropForeignKey
ALTER TABLE `reservation_unit` DROP FOREIGN KEY `reservation_unit_unit_id_fkey`;

-- DropForeignKey
ALTER TABLE `reservation_unit` DROP FOREIGN KEY `reservation_unit_vendor_id_fkey`;

-- DropForeignKey
ALTER TABLE `unit` DROP FOREIGN KEY `unit_vendor_id_fkey`;

-- AlterTable
ALTER TABLE `reservation_transaction` MODIFY `status` ENUM('PENDING', 'SUCCESSFULLY', 'REFUND', 'CANCELED', 'EXPIRED_PAYMENT') NOT NULL DEFAULT 'PENDING';

-- AlterTable
ALTER TABLE `tour_booking_transaction` MODIFY `status` ENUM('PENDING', 'SUCCESSFULLY', 'REFUND', 'CANCELED', 'EXPIRED_PAYMENT') NOT NULL DEFAULT 'PENDING';

-- AlterTable
ALTER TABLE `tour_guide_apply_booking` MODIFY `tour_guide_apply_status` ENUM('NA', 'APPLIED', 'TOUR_GUIDE_CANCELED', 'SYS_CANCELED', 'MATCH_WITH_OTHER') NOT NULL DEFAULT 'NA';

-- AlterTable
ALTER TABLE `vendor` DROP COLUMN `serve_day`,
    ADD COLUMN `end_serve_day` VARCHAR(191) NULL,
    ADD COLUMN `end_serve_time` VARCHAR(191) NULL,
    ADD COLUMN `start_serve_day` VARCHAR(191) NULL,
    ADD COLUMN `start_serve_time` VARCHAR(191) NULL,
    ADD COLUMN `total_slot` INTEGER NOT NULL;

-- DropTable
DROP TABLE `reservation_unit`;

-- DropTable
DROP TABLE `unit`;

-- CreateTable
CREATE TABLE `reservation_vendor` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `vendor_id` INTEGER NOT NULL,
    `customer_id` INTEGER NULL,
    `time` DATETIME(3) NOT NULL,
    `status` ENUM('PENDING', 'WAIT_FOR_CHECK_IN', 'CHECKED_IN', 'SUCCESSFULLY', 'CANCELED') NULL DEFAULT 'PENDING',
    `deposit_amount` DOUBLE NULL,
    `total_price` DOUBLE NULL,
    `total_customer` INTEGER NOT NULL,
    `customer_name` VARCHAR(191) NULL,
    `customer_phone` VARCHAR(191) NULL,
    `reservation_unique_id` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `reservation_vendor` ADD CONSTRAINT `reservation_vendor_vendor_id_fkey` FOREIGN KEY (`vendor_id`) REFERENCES `vendor`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reservation_vendor` ADD CONSTRAINT `reservation_vendor_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reservation_transaction` ADD CONSTRAINT `reservation_transaction_reservation_id_fkey` FOREIGN KEY (`reservation_id`) REFERENCES `reservation_vendor`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
