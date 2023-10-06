/*
  Warnings:

  - A unique constraint covering the columns `[tour_booking_id]` on the table `review` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[reservation_vendor_id]` on the table `review` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `review` ADD COLUMN `reservation_vendor_id` INTEGER NULL,
    ADD COLUMN `tour_booking_id` INTEGER NULL;

-- CreateIndex
CREATE UNIQUE INDEX `review_tour_booking_id_key` ON `review`(`tour_booking_id`);

-- CreateIndex
CREATE UNIQUE INDEX `review_reservation_vendor_id_key` ON `review`(`reservation_vendor_id`);

-- AddForeignKey
ALTER TABLE `review` ADD CONSTRAINT `review_tour_booking_id_fkey` FOREIGN KEY (`tour_booking_id`) REFERENCES `tour_booking`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `review` ADD CONSTRAINT `review_reservation_vendor_id_fkey` FOREIGN KEY (`reservation_vendor_id`) REFERENCES `reservation_vendor`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
