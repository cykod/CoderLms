class InitialTables < ActiveRecord::Migration
  def change

    create_table "users", force: true do |t|
      t.string   "email",                  default: "",    null: false
      t.string   "name"
      t.string   "username"
      t.string   "uid"
      t.integer  "sign_in_count",          default: 0,     null: false
      t.datetime "current_sign_in_at"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "admin",                   default: false
    end

    add_index :users, :uid
    
    create_table "courses" do |t|
      t.string :name
    end

    create_table "user_courses" do |t|
      t.integer :user_id
      t.integer :course_id
      t.boolean :admin, default: false
    end

    add_index :user_courses, :user_id
    add_index :user_courses, :course_id

    create_table "lessons" do |t|
      t.integer :course_id
      t.string :name
      t.integer :number
      t.string :permalink
      t.date :visible_starting
    end

    add_index :lessons, :course_id

    create_table "pages" do |t|
      t.integer :course_id
      t.integer :lesson_id
      t.string :name
      t.string :permalink
      t.integer :number
      t.string :page_type
    end

    add_index :pages, :lesson_id

    create_table "page_files" do |t|
      t.integer :lesson_id
      t.integer :page_id
      t.string :name
      t.string :extension
      t.boolean :editable, default: false
      t.text :body
      t.text :body_html
    end

    add_index :page_files, :page_id

    create_table "user_pages" do |t|
      t.integer :user_id
      t.integer :page_id
      t.integer :views, default: 0
      t.string :permalink # create custom permalink for each user page, 
                          # to prevent copying
    end

    add_index :user_pages, :page_id
    add_index :user_pages, :user_id

    create_table "user_page_files" do |t|
      t.integer :user_id
      t.integer :page_file_id
      t.text :body
      t.text :body_html
    end

    add_index :user_page_files, :user_id
    add_index :user_page_files, :page_file_id

  end
end
