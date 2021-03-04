class WelcomeController < ApplicationController
  def index
  	@users = User.all.map{|user| user.name}
  end
end

