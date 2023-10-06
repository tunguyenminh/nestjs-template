/*
  Warnings:

  - You are about to drop the column `user_id` on the `customer` table. All the data in the column will be lost.
  - You are about to drop the column `user_id` on the `tour_guide` table. All the data in the column will be lost.
  - You are about to drop the column `gender` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `is_verify_otp` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `user_type` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `is_draft` on the `vendor` table. All the data in the column will be lost.
  - You are about to drop the column `user_id` on the `vendor` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `customer` DROP FOREIGN KEY `customer_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `tour_guide` DROP FOREIGN KEY `tour_guide_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `vendor` DROP FOREIGN KEY `vendor_user_id_fkey`;

-- AlterTable
ALTER TABLE `attribute` MODIFY `type` ENUM('TOUR', 'TOUR_GUIDE', 'VENDOR', 'GENERAL') NOT NULL;

-- AlterTable
ALTER TABLE `customer` DROP COLUMN `user_id`;

-- AlterTable
ALTER TABLE `tour_guide` DROP COLUMN `user_id`;

-- AlterTable
ALTER TABLE `user` DROP COLUMN `gender`,
    DROP COLUMN `is_verify_otp`,
    DROP COLUMN `user_type`;

-- AlterTable
ALTER TABLE `vendor` DROP COLUMN `is_draft`,
    DROP COLUMN `user_id`,
    MODIFY `status` ENUM('OPEN', 'DRAFT', 'CLOSED', 'DELETED') NULL;
