class AddGradeToAssignment < ActiveRecord::Migration
  def change
    add_column :user_assignments, :grade, :integer
    add_column :lesson_assignments, :weight, :float, default: 0
  end
end
