/*
  Warnings:

  - Added the required column `updated_at` to the `stories_except` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `stories_specific` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `story_views` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "stories_except" ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "stories_specific" ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "story_views" ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;
