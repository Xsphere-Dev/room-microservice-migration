/*
  Warnings:

  - You are about to drop the column `is_premiumed` on the `users` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "users" DROP COLUMN "is_premiumed",
ADD COLUMN     "is_premium" BOOLEAN NOT NULL DEFAULT false;
