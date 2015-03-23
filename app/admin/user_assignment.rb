LittleBigAdmin.model :user_assignment do

  menu "User Assigments", section: "Models", priority: 20

  index do
    linked_column :id
    column :user
    column :lesson_assignment
    column :url
    column :file do |t|
      if t.file? 
        link_to "File", t.file(:original)
      end
    end
    default_actions
  end


end
