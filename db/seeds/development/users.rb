%w( alice bob carol ).each do |name|
  user = User.new
  user.login_name = name
  user.display_name = name.capitalize
  user.password = "opensesame!"
  user.password_confirmation = "opensesame!"
  user.save!
end