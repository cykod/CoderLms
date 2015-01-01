# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150101205212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "name"
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "course_id"
    t.string  "name"
    t.integer "number"
    t.string  "permalink"
    t.date    "visible_starting"
  end

  add_index "lessons", ["course_id"], name: "index_lessons_on_course_id", using: :btree

  create_table "page_files", force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "page_id"
    t.string  "name"
    t.string  "extension"
    t.boolean "editable",  default: false
    t.text    "body"
    t.text    "body_html"
  end

  add_index "page_files", ["page_id"], name: "index_page_files_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer "course_id"
    t.integer "lesson_id"
    t.string  "name"
    t.string  "permalink"
    t.integer "number"
    t.string  "page_type"
  end

  add_index "pages", ["lesson_id"], name: "index_pages_on_lesson_id", using: :btree

  create_table "user_courses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.boolean "admin",     default: false
  end

  add_index "user_courses", ["course_id"], name: "index_user_courses_on_course_id", using: :btree
  add_index "user_courses", ["user_id"], name: "index_user_courses_on_user_id", using: :btree

  create_table "user_page_files", force: :cascade do |t|
    t.integer "user_id"
    t.integer "page_file_id"
    t.text    "body"
    t.text    "body_html"
  end

  add_index "user_page_files", ["page_file_id"], name: "index_user_page_files_on_page_file_id", using: :btree
  add_index "user_page_files", ["user_id"], name: "index_user_page_files_on_user_id", using: :btree

  create_table "user_pages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "page_id"
    t.integer "views",     default: 0
    t.string  "permalink"
  end

  add_index "user_pages", ["page_id"], name: "index_user_pages_on_page_id", using: :btree
  add_index "user_pages", ["user_id"], name: "index_user_pages_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",              default: "",    null: false
    t.string   "name"
    t.string   "username"
    t.string   "uid"
    t.integer  "sign_in_count",      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",              default: false
  end

  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

end
