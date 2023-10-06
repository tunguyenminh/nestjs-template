/*
  Warnings:

  - You are about to drop the `HotDeal` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `HotDeal` DROP FOREIGN KEY `HotDeal_userId_fkey`;

-- AlterTable
ALTER TABLE `notification_log` ADD COLUMN `is_read` INTEGER NULL DEFAULT 0,
    MODIFY `type` ENUM('TRANSACTION', 'SEND_TO_TOUR_GUIDE_SUBSCRIBE', 'BOOKING_TOUR', 'BOOKING_VENDOR', 'TOUR_GUIDE_APPLIED_CANCELED', 'TOUR_GUIDE_APPLIED', 'TOUR_GUIDE_MATCHED', 'OTHER') NOT NULL DEFAULT 'TRANSACTION';

-- AlterTable
ALTER TABLE `tour_guide` ADD COLUMN `draft` JSON NULL,
    ADD COLUMN `isWaitingForConfirm` BOOLEAN NULL DEFAULT false;

-- DropTable
DROP TABLE `HotDeal`;

-- CreateTable
CREATE TABLE `hot_deal` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NULL,
    `banner_id` VARCHAR(191) NULL,
    `type` ENUM('GENERAL', 'HOME_BANNER_PAGE') NULL DEFAULT 'HOME_BANNER_PAGE',
    `status` ENUM('PUBLISH', 'DRAFT', 'DELETED') NOT NULL DEFAULT 'DRAFT',
    `description` VARCHAR(191) NULL,
    `banner_url` VARCHAR(191) NOT NULL,
    `deep_link_app` VARCHAR(191) NULL,
    `web_link` VARCHAR(191) NULL,
    `from` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `to` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `userId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `hot_deal` ADD CONSTRAINT `hot_deal_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
