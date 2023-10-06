-- AlterTable
ALTER TABLE `customer` ADD COLUMN `notification_status` SMALLINT NULL DEFAULT 1;

-- AlterTable
ALTER TABLE `tour_guide` ADD COLUMN `notification_status` SMALLINT NULL DEFAULT 1;

-- AlterTable
ALTER TABLE `vendor` ADD COLUMN `notification_status` SMALLINT NULL DEFAULT 1;
