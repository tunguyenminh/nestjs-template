-- AlterTable
ALTER TABLE `notification_template` MODIFY `title` VARCHAR(191) NULL DEFAULT 'GOTU';

-- CreateTable
CREATE TABLE `token_messaging` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `token` VARCHAR(191) NOT NULL,
    `status` INTEGER NOT NULL DEFAULT 1,
    `customer_id` INTEGER NULL,
    `vendor_id` INTEGER NULL,
    `tour_guide_id` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `token_messaging_token_key`(`token`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `token_messaging` ADD CONSTRAINT `token_messaging_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `token_messaging` ADD CONSTRAINT `token_messaging_vendor_id_fkey` FOREIGN KEY (`vendor_id`) REFERENCES `vendor`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `token_messaging` ADD CONSTRAINT `token_messaging_tour_guide_id_fkey` FOREIGN KEY (`tour_guide_id`) REFERENCES `tour_guide`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
