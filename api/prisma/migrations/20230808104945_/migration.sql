/*
  Warnings:

  - The values [APPLIED,PICKED,CONFIRMED] on the enum `tour_booking_status` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterTable
ALTER TABLE `tour_booking` MODIFY `status` ENUM('NEW', 'MATCHED', 'SUCCESSFULLY', 'CUSTOMER_CANCELED', 'TOUR_GUIDE_CANCELED', 'SYS_CANCELED') NOT NULL DEFAULT 'NEW';
