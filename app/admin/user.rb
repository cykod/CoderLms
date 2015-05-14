LittleBigAdmin.model :user do

  menu "Users", section: "Models", priority: 20

  index do
    linked_column :id
    linked_column :email
    column :name
    column :username do |user|
      "https://github.com/#{user.username}"
    end
    column :admin
    column :created_at
    default_actions
  end


  show do
    grid do
      panel "Details", size: 2 do
        field :email
        field :name
        field :username
        field :admin
        field :final_grade
      end

      panel "Activity" do
        field :sign_in_count
        field :current_sign_in_at
        field :created_at
      end
    end

    panel "Assignments" do
      table object.user_assignments do |t|
        t.column "Assignment" do |ua|
          ua.lesson_assignment.name
        end
        t.column :late
        t.column :validated do |ua|
          ua.validation_errors.length > 0 ? "No"  : "Yes"
        end
        t.column "Homework" do |ua|
          if ua.lesson_assignment.requires_url?
            link_to ua.url.truncate(30), ua.url, target: "_blank"
          elsif ua.lesson_assignment.requires_file?
            link_to ua.file.url.truncate(30), ua.file.url, target: "_blank"
          end
        end
        t.column "Grade" do |ua|
          render(partial: "/admin/user_grade", locals: { ua: ua })
        end
      end
    end
  end

  form do |f|
    panel "Details" do
      f.row do
        f.text_field :email
        f.text_field :name
      end
      f.row do
        f.text_field :username
        f.select :admin, collection: [ [ "Yes", true ], [ "No", false ]]
      end
    end
    
  end
end
