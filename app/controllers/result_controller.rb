class ResultController < ApplicationController
  def show
  	@first_leader = User.find(params[:leader_id_1].to_i)
  	@second_leader = User.find(params[:leader_id_2].to_i)
  	@third_leader = User.find(params[:leader_id_3].to_i)
  	@fourth_leader = User.find(params[:leader_id_4].to_i)

    @half_round = HalfRound.find(params[:half_round_id].to_i)

    @first_leader_score =  UserScore.find_by(user_id:@first_leader.id, half_round_id: @half_round.id)
    @second_leader_score =  UserScore.find_by(user_id:@second_leader.id, half_round_id: @half_round.id)
    @third_leader_score =  UserScore.find_by(user_id:@third_leader.id, half_round_id: @half_round.id)
    @fourth_leader_score =  UserScore.find_by(user_id:@fourth_leader.id, half_round_id: @half_round.id)

  end
end
