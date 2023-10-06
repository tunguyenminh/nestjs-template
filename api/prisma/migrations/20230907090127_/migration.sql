/*
  Warnings:

  - The values [ACTIVE] on the enum `vendor_status` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterTable
ALTER TABLE `vendor` MODIFY `start_serve_time` VARCHAR(191) NULL,
    MODIFY `start_serve_day` VARCHAR(191) NULL,
    MODIFY `end_serve_day` VARCHAR(191) NULL,
    MODIFY `end_serve_time` VARCHAR(191) NULL,
    MODIFY `status` ENUM('OPEN', 'DRAFT', 'CLOSED', 'DELETED') NULL;
