LittleBigAdmin.model :user_assignment do

  menu "User Assigments", section: "Models", priority: 20

  base_scope { UserAssignment.order("id DESC") }

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

  show do
    grid do 
      panel "Details" do
        if object.file?
          field :file
        end

        if object.url.present?
          field :url
        end
        field :late
        field :created_at
        field :grade
      end

      panel "Assignment" do
        field :lesson_assignment
        field :user
      end
    end
    
  end

  form do |f|
    panel "For" do
      field :lesson_assignment
      field :user
      field :url
    end
    panel "Grading" do
      f.row do
        f.text_field :grade
      end
    end
  end


end
