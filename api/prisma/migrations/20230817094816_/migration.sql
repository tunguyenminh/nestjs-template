/*
  Warnings:

  - You are about to alter the column `language` on the `tour` table. The data in that column could be lost. The data in that column will be cast from `Enum(EnumId(19))` to `Json`.
  - You are about to drop the column `serve_time` on the `vendor` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `tour` ADD COLUMN `admin_created_by` INTEGER NULL,
    MODIFY `language` JSON NULL;

-- AlterTable
ALTER TABLE `vendor` DROP COLUMN `serve_time`;

-- AddForeignKey
ALTER TABLE `tour` ADD CONSTRAINT `tour_admin_created_by_fkey` FOREIGN KEY (`admin_created_by`) REFERENCES `user`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
