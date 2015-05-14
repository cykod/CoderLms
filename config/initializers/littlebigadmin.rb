
LittleBigAdmin.setup do |config|

  config.title = "Coder LMS"

  config.current_permission = -> { current_user.admin? ? :root : nil }

  config.login_path = -> { "/" }
end
