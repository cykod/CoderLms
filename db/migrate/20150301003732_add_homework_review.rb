class AddHomeworkReview < ActiveRecord::Migration
  def change
    add_column :lesson_assignments, :course_id, :integer
    add_column :pages, :lesson_assignment_id, :integer
    add_column :user_course_sessions, :show, :boolean, default: true
  end
end
