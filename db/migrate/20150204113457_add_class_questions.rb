class AddClassQuestions < ActiveRecord::Migration
  def change
    create_table "lesson_theads" do |t|
      t.integer :lesson_id
      t.integer :course_session_id
      t.integer :user_id
      t.boolean :, default: false
      t.text :body
      t.text :y_html
      t.timestamps
    end

    create_table "lesson_responses" do |t|
      t.integer :lesson_thread_id
      t.integer :user_id
      t.integer :position
      t.text :body
      t.text :body_html
      t.timestamps
    end
  end
end
