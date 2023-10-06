-- CreateTable
CREATE TABLE `wish_list_tour` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `tour_id` INTEGER NOT NULL,
    `customer_id` INTEGER NULL,
    `tour_guide_id` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `vendorId` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `wish_list_tour` ADD CONSTRAINT `wish_list_tour_tour_id_fkey` FOREIGN KEY (`tour_id`) REFERENCES `tour`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `wish_list_tour` ADD CONSTRAINT `wish_list_tour_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `wish_list_tour` ADD CONSTRAINT `wish_list_tour_tour_guide_id_fkey` FOREIGN KEY (`tour_guide_id`) REFERENCES `tour_guide`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `wish_list_tour` ADD CONSTRAINT `wish_list_tour_vendorId_fkey` FOREIGN KEY (`vendorId`) REFERENCES `vendor`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
