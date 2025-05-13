/*
  Warnings:

  - You are about to drop the column `main_feed_id` on the `stories_except` table. All the data in the column will be lost.
  - You are about to drop the column `main_feed_id` on the `stories_specific` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[story_id]` on the table `stories_except` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[story_id]` on the table `stories_specific` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `story_id` to the `stories_except` table without a default value. This is not possible if the table is not empty.
  - Added the required column `story_id` to the `stories_specific` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "stories_except" DROP CONSTRAINT "stories_except_main_feed_id_fkey";

-- DropForeignKey
ALTER TABLE "stories_specific" DROP CONSTRAINT "stories_specific_main_feed_id_fkey";

-- DropIndex
DROP INDEX "stories_except_main_feed_id_key";

-- DropIndex
DROP INDEX "stories_specific_main_feed_id_key";

-- AlterTable
ALTER TABLE "stories_except" DROP COLUMN "main_feed_id",
ADD COLUMN     "story_id" VARCHAR(255) NOT NULL;

-- AlterTable
ALTER TABLE "stories_specific" DROP COLUMN "main_feed_id",
ADD COLUMN     "story_id" VARCHAR(255) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "stories_except_story_id_key" ON "stories_except"("story_id");

-- CreateIndex
CREATE UNIQUE INDEX "stories_specific_story_id_key" ON "stories_specific"("story_id");

-- AddForeignKey
ALTER TABLE "stories_specific" ADD CONSTRAINT "stories_specific_story_id_fkey" FOREIGN KEY ("story_id") REFERENCES "stories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stories_except" ADD CONSTRAINT "stories_except_story_id_fkey" FOREIGN KEY ("story_id") REFERENCES "stories"("id") ON DELETE CASCADE ON UPDATE CASCADE;
