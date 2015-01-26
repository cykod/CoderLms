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

  create_table "course_sessions", force: :cascade do |t|
    t.string  "name"
    t.string  "permalink"
    t.integer "course_id"
    t.boolean "open",      default: true
    t.string  "code"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
  end

  create_table "lesson_assignments", force: :cascade do |t|
    t.integer "lesson_id"
    t.text    "body"
    t.text    "body_html"
    t.boolean "requires_url"
    t.boolean "requires_file"
    t.boolean "validate_url"
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "course_id"
    t.string  "name"
    t.integer "position"
    t.string  "permalink"
    t.date    "visible_starting"
    t.date    "due_date"
    t.text    "body"
    t.text    "body_html"
  end

  add_index "lessons", ["course_id"], name: "index_lessons_on_course_id", using: :btree

  create_table "page_files", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "page_id"
    t.string   "name"
    t.string   "extension"
    t.integer  "position"
    t.boolean  "editable",          default: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.text     "body"
    t.text     "body_html"
  end

  add_index "page_files", ["page_id"], name: "index_page_files_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer "course_id"
    t.integer "lesson_id"
    t.string  "name"
    t.integer "position"
    t.string  "page_type"
  end

  add_index "pages", ["lesson_id"], name: "index_pages_on_lesson_id", using: :btree

  create_table "user_assignments", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "lesson_assignment_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "url"
    t.text     "validation_errors"
    t.boolean  "approved"
    t.boolean  "late"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_course_sessions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.integer "course_session_id"
    t.boolean "admin",             default: false
  end

  add_index "user_course_sessions", ["course_id"], name: "index_user_course_sessions_on_course_id", using: :btree
  add_index "user_course_sessions", ["user_id"], name: "index_user_course_sessions_on_user_id", using: :btree

  create_table "user_page_files", force: :cascade do |t|
    t.integer "user_id"
    t.integer "user_page_id"
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
