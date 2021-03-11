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
    @first_leader_score.save!
  	@second_leader_score = UserScore.new(
  		user_id:@second_leader.id, point:init_score, chip:init_chip, half_round_id:@half_round.id
  	)
    @second_leader_score.save!
  	@third_leader_score = UserScore.new(
  		user_id:@third_leader.id, point:init_score, chip:init_chip, half_round_id:@half_round.id
  	)
    @third_leader_score.save!
  	@fourth_leader_score = UserScore.new(
  		user_id:@fourth_leader.id, point:init_score, chip:init_chip, half_round_id:@half_round.id
  	)
    @fourth_leader_score.save!
  	@game = Game.new(
  		honba:0, round:"east", half_round_id: @half_round.id, kyoku:1
  		)
    @game.save!
  end

  def next_game
    @half_round = HalfRound.find(params[:half_round_id].to_i)
    get_players
    previous_game = Game.find(params[:game_id].to_i)
    round, kyoku, honba = get_current_r_k_h(previous_game)
    @game = Game.new(
      honba:honba, round:round, half_round_id: @half_round.id, kyoku: kyoku
      )
    @game.save!
    @first_leader_score = UserScore.find_by(user_id:@first_leader.id, half_round_id: @half_round.id)
    @second_leader_score = UserScore.find_by(user_id:@second_leader.id, half_round_id: @half_round.id)
    @third_leader_score = UserScore.find_by(user_id:@third_leader.id, half_round_id: @half_round.id)
    @fourth_leader_score = UserScore.find_by(user_id:@fourth_leader.id, half_round_id: @half_round.id)
    render "master"
  end

  private
    def get_players
      @first_leader = User.find(params[:first_leader_id])
      @second_leader = User.find(params[:second_leader_id])
      @third_leader = User.find(params[:third_leader_id])
      @fourth_leader = User.find(params[:fourth_leader_id])
    end

    def get_current_r_k_h prev_game
      prev_round = prev_game.round
      prev_kyoku = prev_game.kyoku
      prev_honba = prev_game.honba
      round = prev_round
      kyoku = prev_kyoku
      honba = prev_honba
      # 連荘判定
      is_able_to_move_to_next_kyoku = true

      if is_able_to_move_to_next_kyoku # 連荘でないとき
        if "east" == prev_round 
          if 4 == prev_kyoku
            round = "south"
            kyoku = 1
          else
            kyoku += 1
          end
        elsif "south" == prev_round 
          if 4 == prev_kyoku
            round = "west"
            kyoku = 1
          else
            kyoku += 1
          end
        end
      else # 連荘のとき
        honba += 1
      end
      return round, kyoku, honba
    end
end

