/*
  Warnings:

  - You are about to drop the column `vendorId` on the `wish_list_tour` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `wish_list_tour` DROP FOREIGN KEY `wish_list_tour_vendorId_fkey`;

-- AlterTable
ALTER TABLE `wish_list_tour` DROP COLUMN `vendorId`;

-- CreateTable
CREATE TABLE `wish_list_vendor` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `customer_id` INTEGER NULL,
    `tour_guide_id` INTEGER NULL,
    `vendor_id` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `wish_list_vendor` ADD CONSTRAINT `wish_list_vendor_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `wish_list_vendor` ADD CONSTRAINT `wish_list_vendor_tour_guide_id_fkey` FOREIGN KEY (`tour_guide_id`) REFERENCES `tour_guide`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `wish_list_vendor` ADD CONSTRAINT `wish_list_vendor_vendor_id_fkey` FOREIGN KEY (`vendor_id`) REFERENCES `vendor`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
