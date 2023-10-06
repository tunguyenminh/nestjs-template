-- DropIndex
DROP INDEX `device_device_key_key` ON `device`;

-- AlterTable
ALTER TABLE `notification_log` ADD COLUMN `image_url` VARCHAR(191) NULL;
