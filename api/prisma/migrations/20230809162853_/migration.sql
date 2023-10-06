-- CreateTable
CREATE TABLE `_TourToTourCategory` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_TourToTourCategory_AB_unique`(`A`, `B`),
    INDEX `_TourToTourCategory_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `_TourToTourCategory` ADD CONSTRAINT `_TourToTourCategory_A_fkey` FOREIGN KEY (`A`) REFERENCES `tour`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_TourToTourCategory` ADD CONSTRAINT `_TourToTourCategory_B_fkey` FOREIGN KEY (`B`) REFERENCES `tour_category`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
