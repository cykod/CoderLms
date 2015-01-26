LittleBigAdmin.model :user_course_session do

  menu "User Courses", section: "Models", priority: 30

  instance_name ->(m) { "User Course Session #{m.id}" }

  index do
    linked_column :id
    column :user
    column :course
  end
end
