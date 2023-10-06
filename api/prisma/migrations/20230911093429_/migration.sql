/*
  Warnings:

  - You are about to drop the column `areaId` on the `tour_category` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `tour_category` DROP FOREIGN KEY `tour_category_areaId_fkey`;

-- AlterTable
ALTER TABLE `media` ADD COLUMN `tourGuideDocId` INTEGER NULL,
    MODIFY `type` ENUM('IMAGE', 'VIDEO', 'PDF') NOT NULL;

-- AlterTable
ALTER TABLE `tour_category` DROP COLUMN `areaId`;

-- CreateTable
CREATE TABLE `customer_doc` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `doc_link` VARCHAR(191) NOT NULL,
    `doc_type` ENUM('CID', 'SPECIAL_RESIDENT_PERMIT', 'WORK_PERMIT', 'PASSPORT', 'ANY_DOC', 'LIVENESS') NOT NULL,
    `tour_guide_id` INTEGER NOT NULL,
    `submit_for` VARCHAR(191) NULL,
    `submit_by` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `customer_doc` ADD CONSTRAINT `customer_doc_tour_guide_id_fkey` FOREIGN KEY (`tour_guide_id`) REFERENCES `tour_guide`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `media` ADD CONSTRAINT `media_tourGuideDocId_fkey` FOREIGN KEY (`tourGuideDocId`) REFERENCES `customer_doc`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
