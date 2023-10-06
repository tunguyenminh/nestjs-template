-- CreateTable
CREATE TABLE `user` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_name` VARCHAR(255) NULL,
    `password` VARCHAR(191) NULL,
    `full_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NULL,
    `first_name` VARCHAR(255) NULL,
    `phone_code` VARCHAR(255) NULL DEFAULT '+84',
    `phone` VARCHAR(255) NULL,
    `email` VARCHAR(255) NULL,
    `cid` VARCHAR(191) NULL,
    `avatar` VARCHAR(255) NULL,
    `gender` ENUM('MALE', 'FEMALE', 'OTHER') NULL DEFAULT 'MALE',
    `is_verify_otp` BOOLEAN NOT NULL DEFAULT false,
    `last_access_token` VARCHAR(191) NULL,
    `refresh_token` VARCHAR(191) NULL,
    `user_type` ENUM('ADMIN', 'TOUR_GUIDE', 'VENDOR', 'CUSTOMER') NOT NULL DEFAULT 'CUSTOMER',
    `user_status` ENUM('ACTIVE', 'DELETED', 'BANNED') NOT NULL DEFAULT 'ACTIVE',
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    FULLTEXT INDEX `user_user_name_email_full_name_phone_idx`(`user_name`, `email`, `full_name`, `phone`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customer` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `avatar` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tour_guide` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `avatar` VARCHAR(191) NULL,
    `photo` TEXT NULL,
    `residence_according_to_permanent_address` VARCHAR(191) NULL,
    `current_residence` VARCHAR(191) NULL,
    `name_emergency` VARCHAR(191) NULL,
    `phone_emergency` VARCHAR(191) NULL,
    `relation_ship` VARCHAR(191) NULL,
    `date_of_birth` VARCHAR(191) NULL,
    `description` TEXT NULL,
    `areaId` INTEGER NULL,
    `total_rate` INTEGER NULL DEFAULT 0,
    `avg_rate` INTEGER NULL DEFAULT 0,
    `status` ENUM('VERIFIED', 'PENDING_APPROVAL', 'DEACTIVE', 'DISAPPROVAL', 'DELETED') NULL DEFAULT 'PENDING_APPROVAL',
    `isCertificate` BOOLEAN NULL DEFAULT false,
    `isActive` BOOLEAN NULL DEFAULT true,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `destinationId` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vendor` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `full_name` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(255) NULL,
    `email` VARCHAR(255) NULL,
    `thumbnail` VARCHAR(191) NULL,
    `booking_price` INTEGER NULL,
    `min_price` INTEGER NULL,
    `max_price` INTEGER NULL,
    `opening_time` VARCHAR(191) NULL,
    `closing_time` VARCHAR(191) NULL,
    `opening_day` VARCHAR(191) NULL,
    `closing_day` VARCHAR(191) NULL,
    `description` TEXT NULL,
    `total_rate` INTEGER NULL,
    `avg_ate` INTEGER NULL,
    `is_draft` BOOLEAN NOT NULL DEFAULT false,
    `is_verify` BOOLEAN NOT NULL DEFAULT true,
    `status` ENUM('OPEN', 'CLOSED', 'DELETED') NULL,
    `type` ENUM('NIGHT_CLUB', 'BAR', 'RESTAURANT') NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `destinationId` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `unit` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `vendor_id` INTEGER NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `description` TEXT NULL,
    `status` ENUM('AVAILABLE', 'RESERVED') NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reservation_unit` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `unit_id` INTEGER NULL,
    `vendor_id` INTEGER NOT NULL,
    `customer_id` INTEGER NOT NULL,
    `time` DATETIME(3) NOT NULL,
    `status` ENUM('PENDING', 'CONFIRMED', 'CHECKED_IN', 'SUCCESSFULLY', 'CANCELED') NULL DEFAULT 'PENDING',
    `deposit_amount` INTEGER NULL,
    `total_customer` INTEGER NOT NULL,
    `reservation_unique_id` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reservation_transaction` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `reservation_id` INTEGER NOT NULL,
    `customer_id` INTEGER NOT NULL,
    `time` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `status` ENUM('NA', 'PENDING', 'SUCCESSFULLY', 'REFUND', 'FAILED') NOT NULL DEFAULT 'PENDING',
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tour` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `destination` VARCHAR(191) NULL,
    `description` TEXT NULL,
    `thumbnail` TEXT NULL,
    `number_of_days` INTEGER NOT NULL DEFAULT 1,
    `number_of_nights` INTEGER NULL,
    `price_for_children` INTEGER NULL,
    `price_for_adult` INTEGER NULL,
    `currency_unit` ENUM('VND', 'DOLLAR') NULL,
    `status` ENUM('DRAFT', 'PUBLISH', 'DELETED') NULL DEFAULT 'DRAFT',
    `areaId` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `allowApplyCoupon` BOOLEAN NOT NULL DEFAULT false,
    `allowCancel` BOOLEAN NOT NULL DEFAULT false,
    `createdById` INTEGER NULL,
    `include` VARCHAR(191) NULL,
    `exclude` VARCHAR(191) NULL,
    `avg_rate` DOUBLE NULL,
    `total_rate` INTEGER NULL,
    `language` ENUM('VIETNAMESE', 'ENGLISH') NULL DEFAULT 'VIETNAMESE',

    FULLTEXT INDEX `tour_name_destination_idx`(`name`, `destination`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vendor_subscribe` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `vendorId` INTEGER NOT NULL,
    `tourId` INTEGER NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tour_category` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `thumbnail` VARCHAR(191) NULL,
    `areaId` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tour_category_relation` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `tour_id` INTEGER NOT NULL,
    `category_id` INTEGER NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `area` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `province_code` INTEGER NULL,
    `area_name` VARCHAR(191) NULL,
    `area_code` VARCHAR(191) NULL,
    `code` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `gallery` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `tourId` INTEGER NULL,
    `description` VARCHAR(191) NULL,
    `status` ENUM('ACTIVE', 'IN_ACTIVE') NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `vendorId` INTEGER NULL,
    `tourGuideId` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `media` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `url` VARCHAR(191) NOT NULL,
    `type` ENUM('IMAGE', 'VIDEO') NOT NULL,
    `content` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `galleryId` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tour_booking` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `customer_id` INTEGER NOT NULL,
    `tour_id` INTEGER NOT NULL,
    `tour_guide_id` INTEGER NULL,
    `discount_id` INTEGER NULL,
    `price` INTEGER NOT NULL,
    `total_adult` INTEGER NULL,
    `total_children` INTEGER NULL,
    `start_time` DATETIME(3) NOT NULL,
    `status` ENUM('NEW', 'APPLIED', 'PICKED', 'CONFIRMED', 'CUSTOMER_CANCELED', 'TOUR_GUIDE_CANCELED', 'SYS_CANCELED') NOT NULL DEFAULT 'NEW',
    `end_time` DATETIME(3) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tour_guide_apply_booking` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `tour_booking_id` INTEGER NOT NULL,
    `tour_guide_id` INTEGER NOT NULL,
    `tour_guide_apply_status` ENUM('NA', 'APPLIED', 'TOUR_GUIDE_CANCELED', 'SYS_CANCELED') NOT NULL DEFAULT 'NA',
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tour_booking_transaction` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `tour_booking_id` INTEGER NOT NULL,
    `customer_id` INTEGER NOT NULL,
    `status` ENUM('NA', 'PENDING', 'SUCCESSFULLY', 'REFUND', 'FAILED') NOT NULL DEFAULT 'PENDING',
    `time` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tour_guide_subscribed` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `tourGuideId` INTEGER NOT NULL,
    `tourId` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `discount` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `tour_id` INTEGER NOT NULL,
    `discount` INTEGER NOT NULL DEFAULT 0,
    `description` TEXT NULL,
    `photo` TEXT NULL,
    `start_time` DATETIME(3) NULL,
    `end_time` DATETIME(3) NULL,
    `type` ENUM('SYSTEM', 'VENDOR') NULL,
    `status` ENUM('AVAILABLE', 'UNAVAILABLE') NOT NULL DEFAULT 'AVAILABLE',
    `remaining_amount` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `session` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `access_token` VARCHAR(191) NULL,
    `refresh_token` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `otp` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `action` VARCHAR(191) NOT NULL,
    `user_id` INTEGER NULL,
    `phone` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `is_used` INTEGER NOT NULL DEFAULT 0,
    `expired_at` DATETIME(3) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `notification_template` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(191) NOT NULL,
    `title` VARCHAR(191) NULL,
    `body` VARCHAR(1000) NOT NULL,
    `image` VARCHAR(191) NULL,
    `target` VARCHAR(191) NULL,
    `sms` INTEGER NOT NULL DEFAULT 0,
    `app` INTEGER NOT NULL DEFAULT 1,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `notification_template_type_key`(`type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `action_admin` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `action` VARCHAR(191) NOT NULL,
    `action_key` VARCHAR(191) NOT NULL,
    `action_body` JSON NOT NULL,
    `ip` VARCHAR(191) NOT NULL,
    `user_admin_id` INTEGER NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `review` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `customer_id` INTEGER NOT NULL,
    `tour_id` INTEGER NULL,
    `vendor_id` INTEGER NULL,
    `tour_guide_id` INTEGER NULL,
    `status` VARCHAR(191) NULL,
    `rate` INTEGER NOT NULL DEFAULT 0,
    `content` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attribute` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `type` ENUM('TOUR', 'TOUR_GUIDE', 'VENDOR') NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tour_attribute` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `attributes_id` INTEGER NOT NULL,
    `tour_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vendor_attribute` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `attributes_id` INTEGER NOT NULL,
    `vendor_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tour_guide_payment_method` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `status` ENUM('ACTIVE', 'DEACTIVE', 'DELETED') NULL,
    `bank_name` VARCHAR(191) NULL,
    `bank_code` VARCHAR(191) NULL,
    `receive_name` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `tourGuideId` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `destination` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `latitude` DOUBLE NULL,
    `longitude` DOUBLE NULL,
    `fullAddress` VARCHAR(191) NULL,
    `province_name` VARCHAR(191) NULL,
    `district_name` VARCHAR(191) NULL,
    `ward_name` VARCHAR(191) NULL,
    `province_code` VARCHAR(191) NULL,
    `districtCode` VARCHAR(191) NULL,
    `ward_code` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `customer` ADD CONSTRAINT `customer_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_guide` ADD CONSTRAINT `tour_guide_destinationId_fkey` FOREIGN KEY (`destinationId`) REFERENCES `destination`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_guide` ADD CONSTRAINT `tour_guide_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_guide` ADD CONSTRAINT `tour_guide_areaId_fkey` FOREIGN KEY (`areaId`) REFERENCES `area`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vendor` ADD CONSTRAINT `vendor_destinationId_fkey` FOREIGN KEY (`destinationId`) REFERENCES `destination`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vendor` ADD CONSTRAINT `vendor_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `unit` ADD CONSTRAINT `unit_vendor_id_fkey` FOREIGN KEY (`vendor_id`) REFERENCES `vendor`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reservation_unit` ADD CONSTRAINT `reservation_unit_unit_id_fkey` FOREIGN KEY (`unit_id`) REFERENCES `unit`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reservation_unit` ADD CONSTRAINT `reservation_unit_vendor_id_fkey` FOREIGN KEY (`vendor_id`) REFERENCES `vendor`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reservation_unit` ADD CONSTRAINT `reservation_unit_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reservation_transaction` ADD CONSTRAINT `reservation_transaction_reservation_id_fkey` FOREIGN KEY (`reservation_id`) REFERENCES `reservation_unit`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reservation_transaction` ADD CONSTRAINT `reservation_transaction_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour` ADD CONSTRAINT `tour_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `tour_guide`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour` ADD CONSTRAINT `tour_areaId_fkey` FOREIGN KEY (`areaId`) REFERENCES `area`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vendor_subscribe` ADD CONSTRAINT `vendor_subscribe_vendorId_fkey` FOREIGN KEY (`vendorId`) REFERENCES `vendor`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vendor_subscribe` ADD CONSTRAINT `vendor_subscribe_tourId_fkey` FOREIGN KEY (`tourId`) REFERENCES `tour`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_category` ADD CONSTRAINT `tour_category_areaId_fkey` FOREIGN KEY (`areaId`) REFERENCES `area`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_category_relation` ADD CONSTRAINT `tour_category_relation_tour_id_fkey` FOREIGN KEY (`tour_id`) REFERENCES `tour`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_category_relation` ADD CONSTRAINT `tour_category_relation_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `tour_category`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `gallery` ADD CONSTRAINT `gallery_vendorId_fkey` FOREIGN KEY (`vendorId`) REFERENCES `vendor`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `gallery` ADD CONSTRAINT `gallery_tourGuideId_fkey` FOREIGN KEY (`tourGuideId`) REFERENCES `tour_guide`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `gallery` ADD CONSTRAINT `gallery_tourId_fkey` FOREIGN KEY (`tourId`) REFERENCES `tour`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `media` ADD CONSTRAINT `media_galleryId_fkey` FOREIGN KEY (`galleryId`) REFERENCES `gallery`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_booking` ADD CONSTRAINT `tour_booking_tour_guide_id_fkey` FOREIGN KEY (`tour_guide_id`) REFERENCES `tour_guide`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_booking` ADD CONSTRAINT `tour_booking_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_booking` ADD CONSTRAINT `tour_booking_tour_id_fkey` FOREIGN KEY (`tour_id`) REFERENCES `tour`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_booking` ADD CONSTRAINT `tour_booking_discount_id_fkey` FOREIGN KEY (`discount_id`) REFERENCES `discount`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_guide_apply_booking` ADD CONSTRAINT `tour_guide_apply_booking_tour_guide_id_fkey` FOREIGN KEY (`tour_guide_id`) REFERENCES `tour_guide`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_guide_apply_booking` ADD CONSTRAINT `tour_guide_apply_booking_tour_booking_id_fkey` FOREIGN KEY (`tour_booking_id`) REFERENCES `tour_booking`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_booking_transaction` ADD CONSTRAINT `tour_booking_transaction_tour_booking_id_fkey` FOREIGN KEY (`tour_booking_id`) REFERENCES `tour_booking`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_booking_transaction` ADD CONSTRAINT `tour_booking_transaction_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_guide_subscribed` ADD CONSTRAINT `tour_guide_subscribed_tourGuideId_fkey` FOREIGN KEY (`tourGuideId`) REFERENCES `tour_guide`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_guide_subscribed` ADD CONSTRAINT `tour_guide_subscribed_tourId_fkey` FOREIGN KEY (`tourId`) REFERENCES `tour`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `discount` ADD CONSTRAINT `discount_tour_id_fkey` FOREIGN KEY (`tour_id`) REFERENCES `tour`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `session` ADD CONSTRAINT `session_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `otp` ADD CONSTRAINT `otp_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `review` ADD CONSTRAINT `review_tour_id_fkey` FOREIGN KEY (`tour_id`) REFERENCES `tour`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `review` ADD CONSTRAINT `review_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `review` ADD CONSTRAINT `review_vendor_id_fkey` FOREIGN KEY (`vendor_id`) REFERENCES `vendor`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `review` ADD CONSTRAINT `review_tour_guide_id_fkey` FOREIGN KEY (`tour_guide_id`) REFERENCES `tour_guide`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_attribute` ADD CONSTRAINT `tour_attribute_tour_id_fkey` FOREIGN KEY (`tour_id`) REFERENCES `tour`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_attribute` ADD CONSTRAINT `tour_attribute_attributes_id_fkey` FOREIGN KEY (`attributes_id`) REFERENCES `attribute`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vendor_attribute` ADD CONSTRAINT `vendor_attribute_vendor_id_fkey` FOREIGN KEY (`vendor_id`) REFERENCES `vendor`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vendor_attribute` ADD CONSTRAINT `vendor_attribute_attributes_id_fkey` FOREIGN KEY (`attributes_id`) REFERENCES `attribute`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tour_guide_payment_method` ADD CONSTRAINT `tour_guide_payment_method_tourGuideId_fkey` FOREIGN KEY (`tourGuideId`) REFERENCES `tour_guide`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
