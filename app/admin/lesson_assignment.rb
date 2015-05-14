LittleBigAdmin.model :lesson_assignment do

  menu "Lesson Assignment", section: "Models", priority: 20

  index do
    linked_column :id
    linked_column :body
    linked_column :lesson
    column :requires_url
    column :requires_file
    column :validate_url
    column :weight
    default_actions
  end


  show do
    grid do
      panel "Details", size: 2 do
        field :lesson
        field :course
        field :body_html
        field :weight
        field :requires_url
        field :requires_file
        field :validate_url
      end
    end
  end

  form do |f|
    panel "Details" do
      f.row do
        f.text_field :lesson_id
      end
      f.row do
        f.text_field :body
        f.text_field :weight
      end
      f.row do
        f.check_box :requires_url
        f.check_box :requires_file
        f.check_box :validate_url
      end
    end
    
  end
end
