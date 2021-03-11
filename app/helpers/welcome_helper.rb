module WelcomeHelper
  def user_name_options(options={})
    users = User.all
    users.each do |user|
      options[user.name] = user.id
    end
    options
  end
end
