/*
  Warnings:

  - Made the column `max_customer` on table `tour` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `tour` MODIFY `max_customer` INTEGER NOT NULL DEFAULT 30;
