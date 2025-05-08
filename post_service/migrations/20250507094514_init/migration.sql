-- CreateEnum
CREATE TYPE "feed_audience" AS ENUM ('PUBLIC', 'FRIENDS', 'PRIVATE', 'EXCEPT', 'SPECIFIC', 'FRIENDS_OF_FRIENDS');

-- CreateEnum
CREATE TYPE "media_type" AS ENUM ('IMAGE', 'VIDEO');

-- CreateEnum
CREATE TYPE "reaction_type" AS ENUM ('LIKE', 'LOVE', 'HAHA', 'WOW', 'SAD', 'ANGRY');

-- CreateTable
CREATE TABLE "stories" (
    "id" VARCHAR(255) NOT NULL,
    "user_id" VARCHAR(255) NOT NULL,
    "post_date_time" TIMESTAMP(3) NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "document_id" VARCHAR(255),
    "media_type" "media_type" NOT NULL,
    "feed_audience" "feed_audience" NOT NULL DEFAULT 'FRIENDS',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "stories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stories_specific" (
    "id" VARCHAR(255) NOT NULL,
    "main_feed_id" VARCHAR(255) NOT NULL,
    "user_id" TEXT[],

    CONSTRAINT "stories_specific_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stories_except" (
    "id" VARCHAR(255) NOT NULL,
    "main_feed_id" VARCHAR(255) NOT NULL,
    "user_id" TEXT[],

    CONSTRAINT "stories_except_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "story_views" (
    "id" TEXT NOT NULL,
    "story_id" TEXT NOT NULL,
    "is_story_reaction" BOOLEAN NOT NULL DEFAULT false,
    "reaction_type" "reaction_type",
    "viewer_id" TEXT NOT NULL,
    "viewedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "story_views_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "main_feed" (
    "id" VARCHAR(255) NOT NULL,
    "user_id" VARCHAR(255) NOT NULL,
    "caption" VARCHAR(255),
    "is_sponsored" BOOLEAN NOT NULL DEFAULT false,
    "is_shared" BOOLEAN NOT NULL DEFAULT false,
    "shared_from_id" VARCHAR(255),
    "feed_audience" "feed_audience" NOT NULL DEFAULT 'FRIENDS',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "main_feed_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "main_feed_on_documents" (
    "id" VARCHAR(255) NOT NULL,
    "document_id" VARCHAR(255) NOT NULL,
    "main_feed_id" VARCHAR(255) NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "media_type" "media_type" NOT NULL,
    "view_count" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "main_feed_on_documents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "main_feed_specific" (
    "id" VARCHAR(255) NOT NULL,
    "main_feed_id" VARCHAR(255) NOT NULL,
    "user_id" TEXT[],

    CONSTRAINT "main_feed_specific_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "main_feed_except" (
    "id" VARCHAR(255) NOT NULL,
    "main_feed_id" VARCHAR(255) NOT NULL,
    "user_id" TEXT[],

    CONSTRAINT "main_feed_except_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "documents" (
    "id" VARCHAR(255) NOT NULL,
    "path" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "documents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "main_feed_reaction" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT NOT NULL,
    "post_id" TEXT NOT NULL,
    "reaction_type" TEXT NOT NULL,

    CONSTRAINT "main_feed_reaction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "main_feed_comment" (
    "id" TEXT NOT NULL,
    "post_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "content" TEXT,
    "is_included_media" BOOLEAN NOT NULL DEFAULT false,
    "media_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "main_feed_comment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "main_feed_comment_reply" (
    "id" TEXT NOT NULL,
    "comment_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "content" TEXT,
    "is_included_media" BOOLEAN NOT NULL DEFAULT false,
    "media_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "main_feed_comment_reply_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "stories_document_id_key" ON "stories"("document_id");

-- CreateIndex
CREATE UNIQUE INDEX "stories_specific_main_feed_id_key" ON "stories_specific"("main_feed_id");

-- CreateIndex
CREATE UNIQUE INDEX "stories_except_main_feed_id_key" ON "stories_except"("main_feed_id");

-- CreateIndex
CREATE UNIQUE INDEX "story_views_story_id_viewer_id_key" ON "story_views"("story_id", "viewer_id");

-- CreateIndex
CREATE UNIQUE INDEX "main_feed_specific_main_feed_id_key" ON "main_feed_specific"("main_feed_id");

-- CreateIndex
CREATE UNIQUE INDEX "main_feed_except_main_feed_id_key" ON "main_feed_except"("main_feed_id");

-- CreateIndex
CREATE UNIQUE INDEX "documents_path_key" ON "documents"("path");

-- CreateIndex
CREATE UNIQUE INDEX "main_feed_reaction_user_id_post_id_key" ON "main_feed_reaction"("user_id", "post_id");

-- AddForeignKey
ALTER TABLE "stories" ADD CONSTRAINT "stories_document_id_fkey" FOREIGN KEY ("document_id") REFERENCES "documents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stories_specific" ADD CONSTRAINT "stories_specific_main_feed_id_fkey" FOREIGN KEY ("main_feed_id") REFERENCES "stories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stories_except" ADD CONSTRAINT "stories_except_main_feed_id_fkey" FOREIGN KEY ("main_feed_id") REFERENCES "stories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "story_views" ADD CONSTRAINT "story_views_story_id_fkey" FOREIGN KEY ("story_id") REFERENCES "stories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "main_feed" ADD CONSTRAINT "main_feed_shared_from_id_fkey" FOREIGN KEY ("shared_from_id") REFERENCES "main_feed"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "main_feed_on_documents" ADD CONSTRAINT "main_feed_on_documents_document_id_fkey" FOREIGN KEY ("document_id") REFERENCES "documents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "main_feed_on_documents" ADD CONSTRAINT "main_feed_on_documents_main_feed_id_fkey" FOREIGN KEY ("main_feed_id") REFERENCES "main_feed"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "main_feed_specific" ADD CONSTRAINT "main_feed_specific_main_feed_id_fkey" FOREIGN KEY ("main_feed_id") REFERENCES "main_feed"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "main_feed_except" ADD CONSTRAINT "main_feed_except_main_feed_id_fkey" FOREIGN KEY ("main_feed_id") REFERENCES "main_feed"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "main_feed_comment_reply" ADD CONSTRAINT "main_feed_comment_reply_comment_id_fkey" FOREIGN KEY ("comment_id") REFERENCES "main_feed_comment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
