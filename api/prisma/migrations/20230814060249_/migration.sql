/*
  Warnings:

  - You are about to alter the column `deposit_amount` on the `reservation_unit` table. The data in that column could be lost. The data in that column will be cast from `Int` to `Double`.
  - You are about to alter the column `include` on the `tour` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Json`.
  - You are about to alter the column `exclude` on the `tour` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Json`.
  - You are about to drop the column `sever_day` on the `vendor` table. All the data in the column will be lost.
  - You are about to drop the `_TourToTourCategory` table. If the table is not empty, all the data it contains will be lost.

*/
-- -- DropForeignKey
-- ALTER TABLE `_TourToTourCategory` DROP FOREIGN KEY `_TourToTourCategory_A_fkey`;

-- -- DropForeignKey
-- ALTER TABLE `_TourToTourCategory` DROP FOREIGN KEY `_TourToTourCategory_B_fkey`;

-- DropForeignKey
ALTER TABLE `reservation_transaction` DROP FOREIGN KEY `reservation_transaction_customer_id_fkey`;

-- DropForeignKey
ALTER TABLE `reservation_unit` DROP FOREIGN KEY `reservation_unit_customer_id_fkey`;

-- AlterTable
ALTER TABLE `otp` ADD COLUMN `phone_code` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `reservation_transaction` MODIFY `customer_id` INTEGER NULL;

-- AlterTable
ALTER TABLE `reservation_unit` ADD COLUMN `customer_name` VARCHAR(191) NULL,
    ADD COLUMN `customer_phone` VARCHAR(191) NULL,
    ADD COLUMN `total_price` DOUBLE NULL,
    MODIFY `customer_id` INTEGER NULL,
    MODIFY `deposit_amount` DOUBLE NULL;

-- AlterTable
ALTER TABLE `tour` ADD COLUMN `allow_cancel_time` INTEGER NULL,
    ADD COLUMN `schedules` JSON NULL,
    ADD COLUMN `tour_guide_commission` INTEGER NULL DEFAULT 0,
    MODIFY `include` JSON NULL,
    MODIFY `exclude` JSON NULL;

-- AlterTable
ALTER TABLE `vendor` DROP COLUMN `sever_day`,
    ADD COLUMN `serve_day` VARCHAR(191) NULL;

-- DropTable
DROP TABLE `_TourToTourCategory`;

-- AddForeignKey
ALTER TABLE `reservation_unit` ADD CONSTRAINT `reservation_unit_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reservation_transaction` ADD CONSTRAINT `reservation_transaction_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
