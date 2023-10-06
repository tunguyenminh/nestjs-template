/*
  Warnings:

  - You are about to drop the column `tour_booking_id` on the `review` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `review` DROP FOREIGN KEY `review_tour_booking_id_fkey`;

-- AlterTable
ALTER TABLE `review` DROP COLUMN `tour_booking_id`,
    ADD COLUMN `tour_booking_id_2` INTEGER NULL;

-- AddForeignKey
ALTER TABLE `review` ADD CONSTRAINT `review_tour_booking_id_2_fkey` FOREIGN KEY (`tour_booking_id_2`) REFERENCES `tour_booking`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
