class AddQuizState < ActiveRecord::Migration
  def change
    add_column :page_files, :question, :text
    add_column :page_files, :answers, :text , array: true

    add_column :user_pages, :submitted, :boolean, default: false
    add_column :user_page_files, :correct, :boolean
    add_column :user_page_files, :created_at, :datetime

    add_column :pages, :quiz_state, :string, default: "unstarted"
  end
end
