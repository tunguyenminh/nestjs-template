-- CreateTable
CREATE TABLE `TourGuideArea` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `areaId` INTEGER NULL,
    `tourGuideId` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `TourGuideArea` ADD CONSTRAINT `TourGuideArea_areaId_fkey` FOREIGN KEY (`areaId`) REFERENCES `area`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TourGuideArea` ADD CONSTRAINT `TourGuideArea_tourGuideId_fkey` FOREIGN KEY (`tourGuideId`) REFERENCES `tour_guide`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
