# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181031230015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.text "content", default: "", null: false
    t.text "html_content", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "published_at"
    t.boolean "is_hidden", default: false
    t.text "preview", default: "", null: false
    t.text "html_preview", default: "", null: false
    t.integer "position", default: 0
    t.integer "author_id", null: false
    t.string "image_url"
    t.string "slug"
    t.string "short_description", default: "", null: false
    t.index ["author_id"], name: "index_articles_on_author_id"
    t.index ["slug"], name: "index_articles_on_slug"
  end

  create_table "articles_tags", id: false, force: :cascade do |t|
    t.integer "article_id", null: false
    t.integer "tag_id", null: false
    t.index ["article_id", "tag_id"], name: "index_articles_tags_on_article_id_and_tag_id"
    t.index ["tag_id", "article_id"], name: "index_articles_tags_on_tag_id_and_article_id"
  end

  create_table "employees", id: :serial, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "position", default: 0, null: false
    t.string "profile_picture", null: false
    t.boolean "published", default: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "motivation"
    t.string "facebook_url"
    t.string "twitter_url"
    t.string "linkedin_url"
    t.string "github_url"
  end

  create_table "gallery_images", id: :serial, force: :cascade do |t|
    t.string "image", null: false
    t.integer "position", default: 0, null: false
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "width"
    t.float "height"
    t.index ["project_id"], name: "index_gallery_images_on_project_id"
  end

  create_table "images", id: :serial, force: :cascade do |t|
    t.string "image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", id: :serial, force: :cascade do |t|
    t.string "title", default: "", null: false
    t.string "slug"
    t.string "short_description", default: "", null: false
    t.string "image_url"
    t.text "preview", default: "", null: false
    t.text "html_preview", default: "", null: false
    t.text "content", default: "", null: false
    t.text "html_content", default: "", null: false
    t.boolean "is_hidden", default: true
    t.integer "screencast_id", null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_lessons_on_slug"
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.text "content", default: "", null: false
    t.text "html_content", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_pages_on_slug"
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.text "content", default: "", null: false
    t.text "html_content", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0
    t.boolean "is_hidden", default: true
    t.text "preview", default: "", null: false
    t.text "html_preview", default: "", null: false
    t.string "slug"
    t.string "app_icon"
    t.string "app_store_url"
    t.string "google_play_url"
    t.index ["slug"], name: "index_projects_on_slug"
  end

  create_table "projects_tags", id: false, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "tag_id", null: false
    t.index ["project_id", "tag_id"], name: "index_projects_tags_on_project_id_and_tag_id"
    t.index ["tag_id", "project_id"], name: "index_projects_tags_on_tag_id_and_project_id"
  end

  create_table "screencasts", id: :serial, force: :cascade do |t|
    t.string "title", default: "", null: false
    t.string "slug"
    t.string "short_description", default: "", null: false
    t.string "image_url"
    t.text "preview", default: "", null: false
    t.text "html_preview", default: "", null: false
    t.text "content", default: "", null: false
    t.text "html_content", default: "", null: false
    t.boolean "is_hidden", default: true
    t.integer "topic_id", null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_screencasts_on_slug"
  end

  create_table "sessions", id: :serial, force: :cascade do |t|
    t.string "access_token", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", null: false
    t.index ["title"], name: "index_tags_on_title", unique: true
  end

  create_table "testimonials", id: :serial, force: :cascade do |t|
    t.text "body", null: false
    t.string "company", null: false
    t.string "first_name", null: false
    t.text "html_body", null: false
    t.string "last_name", null: false
    t.string "title", null: false
    t.integer "position", default: 0, null: false
    t.string "profile_picture", null: false
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", id: :serial, force: :cascade do |t|
    t.string "title", default: "", null: false
    t.string "slug"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_hidden", default: true
    t.index ["slug"], name: "index_topics_on_slug"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.index ["email"], name: "index_users_on_email"
  end

end
