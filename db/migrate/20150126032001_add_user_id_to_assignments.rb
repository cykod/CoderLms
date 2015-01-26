class AddUserIdToAssignments < ActiveRecord::Migration
  def change
    add_column :user_assignments, :user_id, :integer
  end
end
