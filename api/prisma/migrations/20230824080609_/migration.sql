-- AlterTable
ALTER TABLE `notification_log` ADD COLUMN `tourGuideId` INTEGER NULL,
    ADD COLUMN `vendorId` INTEGER NULL;

-- AddForeignKey
ALTER TABLE `notification_log` ADD CONSTRAINT `notification_log_vendorId_fkey` FOREIGN KEY (`vendorId`) REFERENCES `vendor`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `notification_log` ADD CONSTRAINT `notification_log_tourGuideId_fkey` FOREIGN KEY (`tourGuideId`) REFERENCES `tour_guide`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
