-- AlterTable
ALTER TABLE `vendor` ADD COLUMN `phone_code` VARCHAR(255) NULL DEFAULT 'VN';

-- CreateTable
CREATE TABLE `VendorType` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_VendorToVendorType` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_VendorToVendorType_AB_unique`(`A`, `B`),
    INDEX `_VendorToVendorType_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `_VendorToVendorType` ADD CONSTRAINT `_VendorToVendorType_A_fkey` FOREIGN KEY (`A`) REFERENCES `vendor`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_VendorToVendorType` ADD CONSTRAINT `_VendorToVendorType_B_fkey` FOREIGN KEY (`B`) REFERENCES `VendorType`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
