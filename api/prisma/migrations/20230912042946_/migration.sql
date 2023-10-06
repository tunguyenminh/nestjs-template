/*
  Warnings:

  - You are about to drop the `customer_doc` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `customer_doc` DROP FOREIGN KEY `customer_doc_tour_guide_id_fkey`;

-- DropForeignKey
ALTER TABLE `media` DROP FOREIGN KEY `media_tourGuideDocId_fkey`;

-- AlterTable
ALTER TABLE `tour_guide` MODIFY `status` ENUM('NEW', 'VERIFIED', 'PENDING_APPROVAL', 'DEACTIVE', 'DISAPPROVAL', 'DELETED') NULL DEFAULT 'PENDING_APPROVAL';

-- DropTable
DROP TABLE `customer_doc`;

-- CreateTable
CREATE TABLE `tour_guide_doc` (
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
ALTER TABLE `tour_guide_doc` ADD CONSTRAINT `tour_guide_doc_tour_guide_id_fkey` FOREIGN KEY (`tour_guide_id`) REFERENCES `tour_guide`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `media` ADD CONSTRAINT `media_tourGuideDocId_fkey` FOREIGN KEY (`tourGuideDocId`) REFERENCES `tour_guide_doc`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
