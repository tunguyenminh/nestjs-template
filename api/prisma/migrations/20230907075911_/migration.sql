/*
  Warnings:

  - You are about to alter the column `start_serve_time` on the `vendor` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Time`.
  - You are about to alter the column `end_serve_time` on the `vendor` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Time`.

*/
-- AlterTable
ALTER TABLE `vendor` MODIFY `start_serve_time` TIME NULL,
    MODIFY `end_serve_time` TIME NULL,
    MODIFY `status` ENUM('ACTIVE', 'DRAFT', 'DELETED') NULL;
