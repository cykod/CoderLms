
LittleBigAdmin.setup do |config|

  config.title = "Coder LMS"

  config.authorize = ->(model, action_name) { current_user.admin? }

  config.login_path = -> { "/" }
end
