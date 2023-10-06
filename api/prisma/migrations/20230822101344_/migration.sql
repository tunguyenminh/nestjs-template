/*
  Warnings:

  - You are about to drop the column `destination` on the `tour` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX `tour_name_destination_idx` ON `tour`;

-- AlterTable
ALTER TABLE `tour` DROP COLUMN `destination`,
    ADD COLUMN `system_price` DOUBLE NULL DEFAULT 50000;

-- AlterTable
ALTER TABLE `vendor` ADD COLUMN `system_price` DOUBLE NULL DEFAULT 50000;

-- CreateIndex
CREATE FULLTEXT INDEX `tour_name_idx` ON `tour`(`name`);
