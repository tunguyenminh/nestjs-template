-- CreateTable
CREATE TABLE `notification_log` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `token_messaging` VARCHAR(191) NOT NULL,
    `customer_id` INTEGER NULL,
    `message` VARCHAR(1000) NOT NULL,
    `data` JSON NOT NULL,
    `type` ENUM('TRANSACTION', 'BOOKING_TOUR', 'BOOKING_VENDOR', 'OTHER') NOT NULL DEFAULT 'TRANSACTION',
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `device` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `device_key` VARCHAR(500) NOT NULL,
    `other_information` VARCHAR(191) NOT NULL,
    `customer_id` INTEGER NULL,
    `tour_guide_id` INTEGER NULL,
    `vendor_id` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `status` ENUM('ACTIVE', 'INACTIVE') NOT NULL DEFAULT 'ACTIVE',

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `notification_log` ADD CONSTRAINT `notification_log_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `device` ADD CONSTRAINT `device_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `device` ADD CONSTRAINT `device_tour_guide_id_fkey` FOREIGN KEY (`tour_guide_id`) REFERENCES `tour_guide`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `device` ADD CONSTRAINT `device_vendor_id_fkey` FOREIGN KEY (`vendor_id`) REFERENCES `vendor`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
