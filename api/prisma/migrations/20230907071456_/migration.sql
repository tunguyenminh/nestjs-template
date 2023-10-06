/*
  Warnings:

  - The values [OPEN,CLOSED] on the enum `vendor_status` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterTable
ALTER TABLE `vendor` MODIFY `status` ENUM('DRAFT', 'DELETED') NULL;
