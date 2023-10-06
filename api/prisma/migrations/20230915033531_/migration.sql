/*
  Warnings:

  - You are about to drop the column `min_price` on the `tour_booking` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `tour` ADD COLUMN `default_number_customer` INTEGER NOT NULL DEFAULT 1;

-- AlterTable
ALTER TABLE `tour_booking` DROP COLUMN `min_price`;
