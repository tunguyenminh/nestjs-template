/*
  Warnings:

  - Made the column `start` on table `vendor_serving` required. This step will fail if there are existing NULL values in that column.
  - Made the column `end` on table `vendor_serving` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `vendor_serving` MODIFY `start` DATETIME(3) NOT NULL,
    MODIFY `end` DATETIME(3) NOT NULL;
