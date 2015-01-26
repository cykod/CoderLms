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
      end

      panel "Activity" do
        field :sign_in_count
        field :current_sign_in_at
        field :created_at
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
