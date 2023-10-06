/*
  Warnings:

  - Added the required column `userId` to the `HotDeal` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `HotDeal` ADD COLUMN `userId` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `HotDeal` ADD CONSTRAINT `HotDeal_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
