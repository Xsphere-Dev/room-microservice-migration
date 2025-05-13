/*
  Warnings:

  - You are about to drop the column `viewedAt` on the `story_views` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "story_views" DROP COLUMN "viewedAt",
ADD COLUMN     "viewed_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;
