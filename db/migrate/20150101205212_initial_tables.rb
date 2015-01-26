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

    create_table "course_sessions" do |t|
      t.string :name
      t.string :permalink
      t.integer :course_id
      t.boolean :open, default: true
      t.string :code
    end

    create_table "user_course_sessions" do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :course_session_id
      t.boolean :admin, default: false
    end

    add_index :user_course_sessions, :user_id
    add_index :user_course_sessions, :course_id

    create_table "lessons" do |t|
      t.integer :course_id
      t.string :name
      t.integer :position
      t.string :permalink
      t.date :visible_starting
      t.date :due_date
      t.text :body
      t.text :body_html
    end

    add_index :lessons, :course_id

    create_table "pages" do |t|
      t.integer :course_id
      t.integer :lesson_id
      t.string :name
      t.integer :position
      t.string :page_type
    end

    add_index :pages, :lesson_id

    create_table "page_files" do |t|
      t.integer :lesson_id
      t.integer :page_id
      t.string :name
      t.string :extension
      t.integer :position
      t.boolean :editable, default: false
      t.attachment :file
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
      t.integer :user_page_id
      t.integer :page_file_id
      t.text :body
      t.text :body_html
    end

    add_index :user_page_files, :user_id
    add_index :user_page_files, :page_file_id


    create_table :lesson_assignments do |t|
      t.integer :lesson_id
      t.text :body
      t.text :body_html
      t.boolean :requires_url
      t.boolean :requires_file
      t.boolean :validate_url
    end

    create_table :user_assignments do |t|
      t.integer :lesson_id
      t.integer :lesson_assignment_id
      t.attachment :file
      t.string :url
      t.text :validation_errors
      t.boolean :approved
      t.boolean :late
      t.timestamps
    end
  end
end
