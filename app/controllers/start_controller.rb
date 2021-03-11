class StartController < ApplicationController
  protect_from_forgery

  def master
  	@first_leader = User.find(params[:east].to_i)
  	@second_leader = User.find(params[:south].to_i)
  	@third_leader = User.find(params[:west].to_i)
  	@fourth_leader = User.find(params[:north].to_i)
  	@half_round = HalfRound.new
  	@half_round.save!
  	init_score = 25000
  	init_chip = 0
  	@first_leader_score = UserScore.new(
  		user_id:@first_leader.id, point:init_score, chip:init_chip, half_round_id:@half_round.id
  	)
  	@second_leader_score = UserScore.new(
  		user_id:@second_leader.id, point:init_score, chip:init_chip, half_round_id:@half_round.id
  	)
  	@third_leader_score = UserScore.new(
  		user_id:@third_leader.id, point:init_score, chip:init_chip, half_round_id:@half_round.id
  	)
  	@fourth_leader_score = UserScore.new(
  		user_id:@fourth_leader.id, point:init_score, chip:init_chip, half_round_id:@half_round.id
  	)
  	@game = Game.new(
  		honba:0, round:"east", half_round_id: @half_round.id, kyoku:1
  		)
  end
end

