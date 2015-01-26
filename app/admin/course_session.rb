LittleBigAdmin.model :course_session do

  menu "Sessions", section: "Models"

  index do
    linked_column :id
    linked_column :name
    linked_column :code
    column :permalink do |session|
      link_to session_path(session), session_path(session), data: { no_turbolink: true }
    end
    column :course
    column :open
    column "Users" do |session|
      session.users.count
    end
  end

  show do
    panel "Details" do
      field :name
      field :open
      field :course
    end
  end

  form do |f|
    panel "details" do
      f.row do
        f.text_field :name
        f.check_box :open
      end

      f.row do
        f.text_field :course_id
        f.text_field :code
      end
    end

  end
end
