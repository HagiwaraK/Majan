class StartController < ApplicationController
  protect_from_forgery

  def master
  	@east_user = User.find(params[:east].to_i)
  	@south_user = User.find(params[:south].to_i)
  	@west_user = User.find(params[:west].to_i)
  	@north_user = User.find(params[:north].to_i)
  end
end

