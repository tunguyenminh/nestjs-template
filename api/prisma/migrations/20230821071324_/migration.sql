/*
  Warnings:

  - You are about to drop the column `deposit_amount` on the `reservation_vendor` table. All the data in the column will be lost.
  - You are about to drop the column `full_name` on the `vendor` table. All the data in the column will be lost.
  - Added the required column `name` to the `vendor` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `customer` DROP FOREIGN KEY `customer_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `tour_guide` DROP FOREIGN KEY `tour_guide_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `vendor` DROP FOREIGN KEY `vendor_user_id_fkey`;

-- AlterTable
ALTER TABLE `customer` ADD COLUMN `cid` VARCHAR(191) NULL,
    ADD COLUMN `email` VARCHAR(255) NULL,
    ADD COLUMN `first_name` VARCHAR(255) NULL,
    ADD COLUMN `gender` ENUM('MALE', 'FEMALE', 'OTHER') NULL DEFAULT 'MALE',
    ADD COLUMN `isUpdateProfile` BOOLEAN NULL DEFAULT false,
    ADD COLUMN `is_verify_otp` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `last_name` VARCHAR(255) NULL,
    ADD COLUMN `password` VARCHAR(191) NULL,
    ADD COLUMN `phone` VARCHAR(255) NULL,
    ADD COLUMN `phone_code` VARCHAR(255) NULL,
    ADD COLUMN `status` ENUM('ACTIVE', 'DELETED', 'BANNED') NOT NULL DEFAULT 'ACTIVE',
    MODIFY `user_id` INTEGER NULL,
    MODIFY `avatar` VARCHAR(255) NULL;

-- AlterTable
ALTER TABLE `reservation_transaction` ADD COLUMN `total_price` DOUBLE NULL;

-- AlterTable
ALTER TABLE `reservation_vendor` DROP COLUMN `deposit_amount`;

-- AlterTable
ALTER TABLE `tour_guide` ADD COLUMN `cid` VARCHAR(191) NULL,
    ADD COLUMN `email` VARCHAR(255) NULL,
    ADD COLUMN `first_name` VARCHAR(255) NULL,
    ADD COLUMN `gender` ENUM('MALE', 'FEMALE', 'OTHER') NULL DEFAULT 'MALE',
    ADD COLUMN `isUpdateProfile` BOOLEAN NULL DEFAULT false,
    ADD COLUMN `last_name` VARCHAR(255) NULL,
    ADD COLUMN `password` VARCHAR(191) NULL,
    ADD COLUMN `phone` VARCHAR(255) NULL,
    ADD COLUMN `phone_code` VARCHAR(255) NULL,
    MODIFY `user_id` INTEGER NULL;

-- AlterTable
ALTER TABLE `vendor` DROP COLUMN `full_name`,
    ADD COLUMN `is_update_profile` BOOLEAN NULL DEFAULT false,
    ADD COLUMN `name` VARCHAR(255) NOT NULL,
    ADD COLUMN `password` VARCHAR(191) NULL,
    MODIFY `user_id` INTEGER NULL;

-- AddForeignKey
ALTER TABLE `customer` ADD CONSTRAINT `customer_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_guide` ADD CONSTRAINT `tour_guide_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vendor` ADD CONSTRAINT `vendor_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
