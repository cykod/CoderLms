LittleBigAdmin.model :course do

  menu "Courses", section: "Models"

  index do
    linked_column :id
    linked_column :name
  end

  show do
    panel "Details"  do
      field :name
    end
  end

  form do |f|
    panel "Details" do
      f.row do
        f.text_field :name
      end
    end
  end
end
