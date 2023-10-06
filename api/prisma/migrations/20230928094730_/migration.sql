/*
  Warnings:

  - You are about to alter the column `avg_rate` on the `tour_guide` table. The data in that column could be lost. The data in that column will be cast from `Int` to `Double`.
  - You are about to alter the column `avg_ate` on the `vendor` table. The data in that column could be lost. The data in that column will be cast from `Int` to `Double`.

*/
-- AlterTable
ALTER TABLE `tour_guide` MODIFY `avg_rate` DOUBLE NULL DEFAULT 0;

-- AlterTable
ALTER TABLE `vendor` MODIFY `avg_ate` DOUBLE NULL;
